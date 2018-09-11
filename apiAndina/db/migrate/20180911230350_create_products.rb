class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :sku
      t.string :desc
      t.string :stock
      t.string :cjxpallet

      t.timestamps
    end
  end
end
