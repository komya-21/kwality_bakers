class EmployeePayrollsController < ApplicationController
  before_action :set_employee_payroll, only: [:show, :edit, :update, :destroy]

  # GET /employee_payrolls
  # GET /employee_payrolls.json
  def index
    @employee_payrolls = EmployeePayroll.all
  end

  # GET /employee_payrolls/1
  # GET /employee_payrolls/1.json
  def show
  end

  # GET /employee_payrolls/new
  def new
    @employee_payroll = EmployeePayroll.new
  end

  # GET /employee_payrolls/1/edit
  def edit
  end
  def earnings
    @earnings = Earning.all
  end
  def deductions
    @deductions = Deduction.all
  end

  # POST /employee_payrolls
  # POST /employee_payrolls.json
  def create
    @employee_payroll = EmployeePayroll.new(employee_payroll_params)

    respond_to do |format|
      if @employee_payroll.save
        if @employee_payroll.is_deduction == false
        Earning.create(employee_payroll_id: @employee_payroll.id)
      else
        Deduction.create(employee_payroll_id: @employee_payroll.id)
      end

        format.html { redirect_to @employee_payroll, notice: 'Employee payroll was successfully created.' }
        format.json { render :show, status: :created, location: @employee_payroll }
      else
        format.html { render :new }
        format.json { render json: @employee_payroll.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employee_payrolls/1
  # PATCH/PUT /employee_payrolls/1.json
  def update
    respond_to do |format|
      if @employee_payroll.update(employee_payroll_params)
        format.html { redirect_to @employee_payroll, notice: 'Employee payroll was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee_payroll }
      else
        format.html { render :edit }
        format.json { render json: @employee_payroll.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employee_payrolls/1
  # DELETE /employee_payrolls/1.json
  def destroy
    @employee_payroll.destroy
    respond_to do |format|
      format.html { redirect_to employee_payrolls_url, notice: 'Employee payroll was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_payroll
      @employee_payroll = EmployeePayroll.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_payroll_params
      params.require(:employee_payroll).permit(:category_name, :percentage, :is_deduction)
    end
end
