class Change

  include ActiveModel::Model

  attr_accessor :key, :previous_value, :value

  def to_hash
    {
      key: self.key,
      previous_value: self.previous_value,
      value: self.value
    }
  end

end
