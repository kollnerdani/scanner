class CreateBills < ActiveRecord::Migration[7.0]
  def change
    create_table :bills do |t|
      t.string :total
      t.boolean :payed, default: false
      t.timestamps
    end
  end
end
