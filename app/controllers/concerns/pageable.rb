module Pageable

  def to_pageable(relation)
    to_pageable_collection to_pageable_relation(relation)
  end

  def to_pageable_relation(relation)
    if params[:page]
      relation = relation.page(params[:page])
      relation = relation.per(params[:per_page]) if params[:per_page]
      if params[:sort_by]
        order = params[:sort_by]
        order = "#{order} #{params[:order]}" if params[:order]
        relation = relation.order order
      end
    end
    relation
  end

  def to_pageable_collection(collection)
    count = collection.respond_to?(:total_count) ? collection.total_count : collection.count
    [ { :total_entries => count }, collection ]
  end

end