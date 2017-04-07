class AddDiscountToPrintingHub < ActiveRecord::Migration[5.0]
  def change
    add_column :printing_hubs, :discount, :decimal
  end
end
