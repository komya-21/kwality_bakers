json.extract! location, :id, :name, :address, :code, :city, :contact, :created_at, :updated_at
json.url location_url(location, format: :json)
