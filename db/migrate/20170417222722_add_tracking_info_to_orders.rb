class AddTrackingInfoToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :tracking_info, :text
  end
end
