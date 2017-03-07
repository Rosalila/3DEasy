class CreateOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :order_items do |t|
      t.integer :order_id
      t.integer :printing_set_id
      t.integer :amount

      t.timestamps
    end
  end
end
