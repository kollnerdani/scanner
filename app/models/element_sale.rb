class ElementSale < ApplicationRecord
  belongs_to :element
  validates :quantity, :sale_price, presence: true, on: :update
end
