class WorkordersController < ApplicationController
  before_action :set_workorder, only: [:show, :edit, :update, :destroy]

  # GET /workorders
  # GET /workorders.json
  def index
    @emp = Employee.find_by(employee_type: "Pasting")

    @emp_cut = Employee.find_by(employee_type: "Cutting")
    @emp_edge = Employee.find_by(employee_type: "Edge Binding")
    @emp_pack = Employee.find_by(employee_type: "Packing & Quality")
    if current_user.role == "SuperAdmin"
     @workorders = Workorder.all
     if params[:param1].present? && params[:param1] == 'false'

      workorder = Workorder.list(params[:id])

      workorder.update!(approve: true)

      @employee_workorder = EmployeesWorkorder.create(employee_id: @emp.id,workorder_id: workorder.id ,status: "Pending")


    elsif params[:param1].present? && params[:param1] == 'true'

      workorder = Workorder.list(params[:id])

      workorder.update!(approve: false) 

      
    end 
  end

  if current_user.role == "Employee"
    if current_user.employee.employee_type == "Pasting"

      @workorders = Employee.find(@emp.id).workorders
    elsif current_user.employee.employee_type == "Cutting"


      @workorders = Employee.find(@emp_cut.id).workorders
    elsif current_user.employee.employee_type == "Edge Binding"
      @workorders = Employee.find(@emp_edge.id).workorders
    elsif current_user.employee.employee_type == "Packing & Quality"
      @workorders = Employee.find(@emp_pack.id).workorders
    end

  elsif current_user.role == "Vendor"

    @workorders = Workorder.where(vendor_id: current_user.vendor_id)
  end



end

  # GET /workorders/1
  # GET /workorders/1.json
  def show
    #@qr = RQRCode::QRCode.new(@workorder.order_no, size: 4)
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "payment.pdf.erb"    # Excluding ".pdf" extension.
      end
    end
    @employee1 = @workorder.employees.find_by(employee_type: "Pasting")
    @employee2 = @workorder.employees.find_by(employee_type: "Cutting")
    @employee3 = @workorder.employees.find_by(employee_type: "Edge Binding")
    @employee4 = @workorder.employees.find_by(employee_type: "Packing & Quality")

  end

  # GET /workorders/new
  def new
    @workorder = Workorder.new
    @workorder.order_num
  end

  # GET /workorders/1/edit
  def edit
    #@workorder = Workorder.find(params[:id])
    #@workorder = Workorder.includes({ fproducts: :measurements }).find(params[:id])
  end
  def end_time

    @end = params[:endtime]
    @employee_id = params[:employee_id]
    @workorder_id = params[:workorder_id]
    @emp_work =  EmployeesWorkorder.find_by(["employee_id = ? and workorder_id = ?",@employee_id,@workorder_id])

    @emp_work.update(endtime: @end)
    @emp_work.update(status: "Completed")
    if Employee.find(@employee_id).employee_type == "Pasting"
      @id = Employee.find_by(employee_type: "Cutting")
    elsif Employee.find(@employee_id).employee_type == "Cutting"
      @id = Employee.find_by(employee_type: "Edge Binding")
    elsif Employee.find(@employee_id).employee_type == "Edge Binding"
      @id = Employee.find_by(employee_type: "Packing & Quality")
    end

    EmployeesWorkorder.create(employee_id: @id.id,workorder_id: @workorder_id ,status: "Pending")



  end

  def status_update


    @status = params[:status]
    @employee_id = params[:employee_id]
    @workorder_id = params[:workorder_id]
    @emp_work =  EmployeesWorkorder.find_by(["employee_id = ? and workorder_id = ?",@employee_id,@workorder_id])

    @emp_work.update(status: @status)

  end

  # POST /workorders
  # POST /workorders.json
  def create
    @workorder = Workorder.new(workorder_params)


    respond_to do |format|

      if @workorder.save



        @workorder.update(approve: false)
        if current_user.role == "Vendor"
          @workorder.update(vendor_id: current_user.vendor_id)
        end
        format.html { redirect_to @workorder, notice: 'Workorder was successfully created.' }
        format.json { render :show, status: :created, location: @workorder }
      else
        format.html { render :new }
        format.json { render json: @workorder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workorders/1
  # PATCH/PUT /workorders/1.json
  def update

    respond_to do |format|
      if @workorder.update(workorder_params)


        format.html { redirect_to @workorder, notice: 'Workorder was successfully updated.' }
        format.json { render :show, status: :ok, location: @workorder }
      else
        format.html { render :edit }
        format.json { render json: @workorder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workorders/1
  # DELETE /workorders/1.json
  def destroy
    @workorder.destroy
    respond_to do |format|
      format.html { redirect_to workorders_url, notice: 'Workorder was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def workorder_pdf
    @workorder = Workorder.find(params[:id])
    @qr = RQRCode::QRCode.new(@workorder.order_no, size: 4)
    @rates = Rate.all
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "workorder_pdf.pdf.erb" 
        response.headers['Content-Disposition'] = 'attachment;' "filename= \"#{@workorder.order_no}\".pdf"  # Excluding ".pdf" extension.
      end
    end
  end
  def workorder_invoice
    @workorder = Workorder.find(params[:id])
    @rates = Rate.all
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "workorder_invoice.pdf.erb" 
        response.headers['Content-Disposition'] = 'attachment;' "filename= \"#{@workorder.order_no}\".pdf"  # Excluding ".pdf" extension.
      end
    end
  end
  def order_report

    @start = params[:starttime]
    @end = params[:endtime]

    @employee_id = params[:employee_id]
    @workorder_id = params[:workorder_id]
    @emp_work =  EmployeesWorkorder.find_by(["employee_id = ? and workorder_id = ?",@employee_id,@workorder_id])

    @emp_work.update(starttime: @start)
    @emp_work.update(status: "Working")

  end
  def order_status
    @employee_workorders = EmployeesWorkorder.all
    @workorders = Workorder.all
  end
  def workorder_status
    @workorder = Workorder.find(params[:id])
    @employee_workorder = EmployeesWorkorder.find_by(workorder_id: params[:id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workorder
      @workorder = Workorder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def workorder_params
     params.require(:workorder).permit(:order_no ,:date,:employee_id,:remove_photo1,:remove_photo2,:remove_photo3,:remove_photo4,:remove_photo5 ,:vendor_id,:name1,:photo1,:name2,:photo2,:name3,:photo3,:name4,:photo4,:name5,:photo5,fproducts_attributes: [:id ,:product,:workorder_id,:_destroy ,measurements_attributes: [:id,:ftype,:width,:height,:depth,:color_id,:side,:skirting,:horizontal,:vertical,:center,:total,:fproduct_id, :quantity,:_destroy]])

   end
 end
