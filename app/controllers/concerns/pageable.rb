module Pageable

  def to_pageable(relation, options={})
    to_pageable_collection to_pageable_relation(relation, options)
  end

  def to_pageable_relation(relation, options={})
    if params[:page].present?
      # FIXME workaround, should be cached !
      clazz = relation.name.constantize
      @belongs_to_attributes ||= clazz.reflect_on_all_associations(:belongs_to).map { |a| a.name.to_s }
      relation = relation.page(params[:page])
      relation = relation.per(params[:per_page]) if params[:per_page].present?
      relation = apply_order(relation)
    end
    relation
  end

  def apply_order(relation)
    if params[:sort_by].present?
      order = to_order_key params[:sort_by]
      order = "#{order} #{params[:order]}" if params[:order].present?
      relation = relation.order order
    end
    relation
  end

  def to_order_key(key)
    if @belongs_to_attributes.include? key
      key = "#{key}_id"
    end
    key
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