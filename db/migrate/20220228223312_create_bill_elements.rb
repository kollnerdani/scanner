class CreateBillElements < ActiveRecord::Migration[7.0]
  def change
    create_table :bill_elements do |t|
      t.references :bill, null: false, foreign_key: true
      t.references :element, null: false, foreign_key: true

      t.timestamps
    end
  end
end
