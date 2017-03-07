json.extract! order, :id, :user_id, :printing_set_id, :order_state_id, :doge_address, :shipping_address, :shipping_type_id, :created_at, :updated_at
json.url order_url(order, format: :json)
