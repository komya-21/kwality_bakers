class Payslip < ApplicationRecord
  belongs_to :employee,optional: true
  belongs_to :earning,optional: true
  belongs_to :deduction,optional: true
  

def date_label
	 date.strftime("%B %Y")
	
	
end
end
