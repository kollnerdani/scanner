class CreateElementSales < ActiveRecord::Migration[7.0]
  def change
    create_table :element_sales do |t|
      t.references :element, null: false, foreign_key: true
      t.integer :quantity
      t.decimal :sale_price
      t.boolean :active, default: true
      t.timestamps
    end
  end
end
