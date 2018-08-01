json.extract! work_order, :id, :width, :depth, :height, :quantity, :color_id, :side, :skirting, :horizontal, :vertical, :center, :total, :created_at, :updated_at
json.url work_order_url(work_order, format: :json)
