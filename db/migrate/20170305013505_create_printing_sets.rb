class CreatePrintingSets < ActiveRecord::Migration[5.0]
  def change
    create_table :printing_sets do |t|
      t.string :name
      t.string :image
      t.text :description
      t.integer :printing_hub_id
      t.decimal :doges

      t.timestamps
    end
  end
end
