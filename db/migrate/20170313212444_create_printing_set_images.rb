class CreatePrintingSetImages < ActiveRecord::Migration[5.0]
  def change
    create_table :printing_set_images do |t|
      t.integer :printing_set_id
      t.string :image

      t.timestamps
    end
  end
end
