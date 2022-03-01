class Bill < ApplicationRecord
  has_many :bill_elements
  validate :is_payed, on: :update
private
  def is_payed
    if self.bill_elements.empty?
      errors.add(:id, "Empty bill" )
    end
  end
end
