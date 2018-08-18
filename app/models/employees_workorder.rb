class EmployeesWorkorder < ApplicationRecord
  belongs_to :employee
  belongs_to :workorder

  
  
end
