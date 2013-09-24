module Pageable

  def to_pageable(relation, options={})
    to_pageable_collection to_pageable_relation(relation, options)
  end

  def to_pageable_relation(relation, options={})
    if params[:page].present?
      relation = relation.page(params[:page])
      relation = relation.per(params[:per_page]) if params[:per_page].present?
      orders = []
      if params[:sort_by].present?
        order = params[:sort_by]
        order = "#{order} #{params[:order]}" if params[:order].present?
        orders << order
      end
      orders << options[:order] if options[:order].present?
      relation = relation.order orders.join(", ")
    end
    relation
  end

  def to_pageable_collection(collection)
    count = collection.respond_to?(:total_count) ? collection.total_count : collection.count
    page = collection.current_page
    pages = collection.num_pages
    [
      {
        :total_entries => count,
        :first_page => 1,
        :next_page => page + 1 <= pages ? page + 1 : nil,
        :prev_page => page > 1 ? page - 1 : nil,
        :last_page => pages
      },
      collection
    ]
  end

end