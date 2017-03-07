class CreatePrintables < ActiveRecord::Migration[5.0]
  def change
    create_table :printables do |t|
      t.integer :printing_set_id
      t.string :github_repo

      t.timestamps
    end
  end
end
