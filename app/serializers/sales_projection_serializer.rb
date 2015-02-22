class SalesProjectionSerializer < ActiveModel::Serializer
  attributes :class_name, 
    :id,
    :year,
    :period,
    :amount,
    :accuracy,
    :status,
    :start_date,
    :end_date,
    :order_date,
    :profit_amount,
    :profit_rate,
    :obic_no,
    :remarks,
    :updated_at

  has_one :deal
  def class_name
    object.class.name
  end
end
