require 'test_helper'

class EmployeePayrollsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @employee_payroll = employee_payrolls(:one)
  end

  test "should get index" do
    get employee_payrolls_url
    assert_response :success
  end

  test "should get new" do
    get new_employee_payroll_url
    assert_response :success
  end

  test "should create employee_payroll" do
    assert_difference('EmployeePayroll.count') do
      post employee_payrolls_url, params: { employee_payroll: { category_name: @employee_payroll.category_name, is_deduction: @employee_payroll.is_deduction, percentage: @employee_payroll.percentage } }
    end

    assert_redirected_to employee_payroll_url(EmployeePayroll.last)
  end

  test "should show employee_payroll" do
    get employee_payroll_url(@employee_payroll)
    assert_response :success
  end

  test "should get edit" do
    get edit_employee_payroll_url(@employee_payroll)
    assert_response :success
  end

  test "should update employee_payroll" do
    patch employee_payroll_url(@employee_payroll), params: { employee_payroll: { category_name: @employee_payroll.category_name, is_deduction: @employee_payroll.is_deduction, percentage: @employee_payroll.percentage } }
    assert_redirected_to employee_payroll_url(@employee_payroll)
  end

  test "should destroy employee_payroll" do
    assert_difference('EmployeePayroll.count', -1) do
      delete employee_payroll_url(@employee_payroll)
    end

    assert_redirected_to employee_payrolls_url
  end
end
