class CreateElements < ActiveRecord::Migration[7.0]
  def change
    create_table :elements do |t|
      t.decimal :price
      t.string :code
      t.boolean :sale
      t.timestamps
    end
  end
end
