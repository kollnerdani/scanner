class Element < ApplicationRecord
  has_many :element_sales
  accepts_nested_attributes_for :element_sales, update_only: true
  validates :code, :price, presence:true
end
