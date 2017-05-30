class CreateCupons < ActiveRecord::Migration[5.0]
  def change
    create_table :cupons do |t|
      t.string :code
      t.integer :discount
      t.datetime :end_date
      t.integer :printing_hub_id

      t.timestamps
    end
  end
end
