class Employee < ApplicationRecord
	after_save :create_user_account

	def emp_no
    date = Date.today.strftime('%Y%m%d')
    self.employee_no = date.to_s + '1' if Employee.first.nil?
    self.employee_no = date.to_s + \
                          Employee.last.id.next.to_s unless Employee.first.nil?
  end

   private

  def create_user_account
      User.create!(email: self.email, password: self.employee_no, role: 'Employee')
  end

end
