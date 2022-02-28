class BillElement < ApplicationRecord
  belongs_to :bill
  belongs_to :element
end
