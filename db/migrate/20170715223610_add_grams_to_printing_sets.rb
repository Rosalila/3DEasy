class AddGramsToPrintingSets < ActiveRecord::Migration[5.0]
  def change
    add_column :printing_sets, :grams, :integer
  end
end
