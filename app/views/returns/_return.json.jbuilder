json.extract! return, :id, :date_of_return, :invoice_number, :vendor_id, :inward_product_id, :return_quantity, :purpose, :receipt_no, :return_type, :created_at, :updated_at
json.url return_url(return, format: :json)
