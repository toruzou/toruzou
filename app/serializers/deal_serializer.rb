class DealSerializer < ActiveModel::Serializer
  attributes :id, :organization_id, :counter_person, :pm, :sales, :start_date, :order_date, :accept_date, :amount, :accuracy, :status
end
