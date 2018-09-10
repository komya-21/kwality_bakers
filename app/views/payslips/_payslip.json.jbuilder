json.extract! payslip, :id, :employee_id, :earning_id, :deduction_id, :date, :basic_salary, :created_at, :updated_at
json.url payslip_url(payslip, format: :json)
