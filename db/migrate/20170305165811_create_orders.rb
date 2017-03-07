class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :printing_hub_id
      t.integer :order_state_id
      t.integer :shipping_type_id
      t.string :doge_address
      t.text :shipping_address
      t.integer :doges

      t.timestamps
    end
  end
end
