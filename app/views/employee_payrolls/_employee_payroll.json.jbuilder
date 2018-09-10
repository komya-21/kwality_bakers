json.extract! employee_payroll, :id, :category_name, :percentage, :is_deduction, :created_at, :updated_at
json.url employee_payroll_url(employee_payroll, format: :json)
