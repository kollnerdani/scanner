class BillElement < ApplicationRecord
  belongs_to :bill
  belongs_to :element
  validates :original_element, presence: true
end
