class DealSerializer < ActiveModel::Serializer
  attributes :id, :pj_type, :organization_id, :counter_person, :pm, :sales, :start_date, :order_date, :accept_date, :amount, :accuracy, :status
end
