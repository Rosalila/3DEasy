class CreateUserInPrintingHubs < ActiveRecord::Migration[5.0]
  def change
    create_table :user_in_printing_hubs do |t|
      t.integer :user_id
      t.integer :printing_hub_id

      t.timestamps
    end
  end
end
