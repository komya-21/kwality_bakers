json.extract! workorder, :id, :created_at, :updated_at
json.url workorder_url(workorder, format: :json)
