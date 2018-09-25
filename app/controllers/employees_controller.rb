class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token,  :if => Proc.new { |c| c.request.format == 'application/json' }

  # GET /employees
  # GET /employees.json
  def index
    if current_user.role == "SuperAdmin"
    @employees = Employee.all
  elsif current_user.role == "Center"
    @employees = Employee.where(location_id: current_user.location_id)
  end
    #@employees = Employee.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
  end

  def update_empwork

    @empwork = EmpWork.find(params[:id])
    @in_time = EmpWork.find_by(employee_id: @empwork.employee_id,date: @empwork.date).in_time
    start_time = @in_time
    

    if @empwork.update(empwork_params)
      @out_time = @empwork.out_time
      end_time = @out_time
      @wt = TimeDifference.between(start_time, end_time).in_hours
      EmpWork.find_by(employee_id: @empwork.employee_id,date: @empwork.date).update(work_hours: @wt)
      render json: @empwork, status: :updated
    else
      render json: @empwork.errors, status: :unprocessable_entity
    end

  end
def create_empwork
  @empwork = EmpWork.new(empwork_params)
   if @empwork.save
    render json: @empwork, status: :created
   else
    render json: @empwork.errors, status: :unprocessable_entity
   end
end

  def in_time
   
    
 
 

    @in_time = params[:in_time]
    @date = params[:date]
    @emp_id = params[:employee_id]
    EmpWork.create(in_time: @in_time , date: @date , employee_id: @emp_id)
  end

  def out_time
    @out_time = params[:out_time]
    @date = params[:date]
    @emp_id = params[:employee_id]
    @in_time = EmpWork.find_by(employee_id: @emp_id,date: @date).in_time
    start_time = @in_time
    end_time = @out_time

    @wt = TimeDifference.between(start_time, end_time).in_hours

    #@wt = params[:work_hours]
    @emp = EmpWork.find_by(date: @date)
    EmpWork.find_by(employee_id: @emp_id,date: @date).update(out_time: @out_time,work_hours: @wt)
  end

  # GET /employees/new
  def new
    @employee = Employee.new
    @employee.emp_no
  end

  def report

  end

  def empwork
    @emp_works = EmpWork.all
    respond_to do |format|
      format.html
      format.json { render json: @emp_works}
    end
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        if current_user.role == "Center"
         
          @employee.update!(location_id: current_user.location_id)
        end
        format.html { redirect_to @employee, notice: 'Employee was successfully created.' }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_url, notice: 'Employee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:name, :contact_no, :email, :address, :employee_no,:employee_type,:location_id)
    end
    def empwork_params
      params.require(:emp_work).permit(:in_time,:out_time,:date,:employee_id)
    end
end
