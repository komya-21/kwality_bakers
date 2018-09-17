json.extract! supplier, :id, :name, :address, :contact, :email, :created_at, :updated_at
json.url supplier_url(supplier, format: :json)
