class CreateShippingTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :shipping_types do |t|
      t.string :name
      t.integer :printing_hub_id
      t.decimal :doges

      t.timestamps
    end
  end
end
