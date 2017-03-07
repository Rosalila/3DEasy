class CreatePrinters < ActiveRecord::Migration[5.0]
  def change
    create_table :printers do |t|
      t.integer :printing_hub_id
      t.string :name
      t.string :ip
      t.string :api_user
      t.string :api_key

      t.timestamps
    end
  end
end
