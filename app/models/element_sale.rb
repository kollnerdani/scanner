class ElementSale < ApplicationRecord
  belongs_to :element, dependent: :destroy
  validates :quantity, :sale_price, presence: true, on: :update
end
