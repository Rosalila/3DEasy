json.extract! printer, :id, :user_id, :name, :ip, :api_key, :created_at, :updated_at
json.url printer_url(printer, format: :json)
