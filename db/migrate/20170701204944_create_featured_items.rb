class CreateFeaturedItems < ActiveRecord::Migration[5.0]
  def change
    create_table :featured_items do |t|
      t.integer :printing_set_id

      t.timestamps
    end
  end
end
