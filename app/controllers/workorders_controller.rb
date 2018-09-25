class WorkordersController < ApplicationController
  before_action :set_workorder, only: [:show, :edit, :update, :destroy]

  # GET /workorders
  # GET /workorders.json
  def index
    @emps = Employee.where(employee_type: "Pasting")

    @emp_cuts = Employee.where(employee_type: "Cutting")
    @emp_edges = Employee.where(employee_type: "Edge Binding")
    @emp_packs = Employee.where(employee_type: "Packing & Quality")
    
   if current_user.present?
    if current_user.role == "SuperAdmin"
     @workorders = Workorder.order(created_at: :desc)
     

     if params[:param1].present? && params[:param1] == 'false'

      workorder = Workorder.list(params[:id])
      @emp = @emps.find_by(location_id: workorder.location_id)
      workorder.update!(approve: true)

      @employee_workorder = EmployeesWorkorder.create(employee_id: @emp.id,workorder_id: workorder.id ,status: "Pending")


    elsif params[:param1].present? && params[:param1] == 'true'

      workorder = Workorder.list(params[:id])

      workorder.update!(approve: false) 

      
    end 
  end

  if current_user.role == "Employee"
    if current_user.employee.employee_type == "Pasting"
 @emp = @emps.find_by(location_id: current_user.employee.location_id)
      @workorders = Employee.find(@emp.id).workorders
    elsif current_user.employee.employee_type == "Cutting"
    @emp_cut = @emp_cuts.find_by(location_id: current_user.employee.location_id)

      @workorders = Employee.find(@emp_cut.id).workorders
    elsif current_user.employee.employee_type == "Edge Binding"
       @emp_edge = @emp_edges.find_by(location_id: current_user.employee.location_id)
      @workorders = Employee.find(@emp_edge.id).workorders
    elsif current_user.employee.employee_type == "Packing & Quality"
       @emp_pack = @emp_packs.find_by(location_id: current_user.employee.location_id)
      @workorders = Employee.find(@emp_pack.id).workorders
    end

  elsif current_user.role == "Vendor"
   

    @workorders = Workorder.where(["vendor_id = ? and location_id = ?", current_user.vendor_id,current_user.vendor.location_id])
  elsif current_user.role == "Center"
    @workorders = Workorder.where(location_id: current_user.location_id)
  end

   end   
 


end
def invoice
  @workorder = Workorder.find(params[:id])
    @rates = Rate.all
  end
  def invoicee
     @workorder = Workorder.find(params[:id])
    @rates = Rate.all
  end


def location_report
  
 @report_type = params[:report_type]
 @location = params[:location]

 if (@report_type == "Workorders")
  @workorders = Workorder.where(location_id: @location)
elsif @report_type == "Employees"
  @employees = Employee.where(location_id: @location)
elsif @report_type == "Vendors"
  @vendors = Vendor.where(location_id: @location)
else
  @emp_workorders = EmployeesWorkorder.all
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
    @employee1 = @workorder.employees.find_by(["employee_type = ? and location_id=?" ,"Pasting",@workorder.location_id])
    @employee2 = @workorder.employees.find_by(["employee_type = ? and location_id=?" , "Cutting",@workorder.location_id])
    @employee3 = @workorder.employees.find_by(["employee_type = ? and location_id=?" , "Edge Binding",@workorder.location_id])
    @employee4 = @workorder.employees.find_by(["employee_type = ? and location_id=?" , "Packing & Quality",@workorder.location_id])

  end

  # GET /workorders/new
  def new
    @workorder = Workorder.new
    @workorder.order_num
    
    
    @vendors = Vendor.where(location_id: current_user.location_id)
   
  end

  # GET /workorders/1/edit
  def edit
    #@workorder = Workorder.find(params[:id])
    #@workorder = Workorder.includes({ fproducts: :measurements }).find(params[:id])
  end

  def invoice_list
    if current_user.role == "Vendor"
      @workorders = Workorder.where(vendor_id: current_user.vendor_id).order(:invoice_no)
    else
    @workorders = Workorder.order(:invoice_no)
  end
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
        @workorder.update(payment_status: false)

        
        date = Date.today.strftime('%Y%m%d')
        invoice_num = 'IN' + date.to_s + @workorder.id.to_s
        @workorder.update(invoice_no: invoice_num )
        @workorder.update(approve: false)
        @workorder.fproducts.each do |f| 
        f.measurements.each do |m|
          if m.ftype == "Carcass Box"
            @rate1 = Rate.find_by(["product = ? and ptype = ? and ctype = ?",f.product,m.ftype,"Back" ])
            @rate2 = Rate.find_by(["product = ? and ptype = ? and ctype = ?",f.product,m.ftype,"TB/LR" ])
            m.update(back_rate: @rate1.price)
            m.update(rate: @rate2.price)
          else
            @rate1 = Rate.find_by(["product = ? and ptype = ?",f.product,m.ftype])
            m.update(rate: @rate1.price)
          end
      end
    end
    if current_user.role == "Vendor"
      @workorder.update(vendor_id: current_user.vendor_id)
      @workorder.update(location_id: current_user.vendor.location_id)
      elsif current_user.role == "Center"
        @workorder.update(location_id: current_user.location_id)
      end
      format.html { redirect_to @workorder, notice: 'Workorder was successfully created.' }
      format.json { render :show, status: :created, location: @workorder }
    else
      format.html { render :new }
      format.json { render json: @workorder.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit_rate
    @rate = params[:rate]
    @back_rate = params[:back_rate]
    @id = params[:id]
    @k = @id.select{|p| p!=""}
    @r = @rate.select{|r| r!=""}
    @rt = @r[0].to_f
    @m = @k[0].to_i
    Measurement.find(@m).update(rate: @rt)
    Measurement.find(@m).update(back_rate: @back_rate)
  end
  def delivery_status
    @d_status = params[:delivered]
    @w_id = params[:workorder_id]
    
    Workorder.find(@w_id).update(delivered: true)
  end

def payment_status_report
  @payment_status = params[:payment_status]

  @vendor_id = params[:vendor_id]
  @workorders = Workorder.where(vendor_id: @vendor_id)
   

    if @payment_status == 'PAID'
         

      @returns = Workorder.list1
    elsif @payment_status == 'PENDING'
      @returns = Workorder.list2
    else
      @returns = Workorder.all
    end 
end

def workorder_status_report
  
  @status = params[:t]

  
  if @status == "Not Approved"
    @workorders = Workorder.where(approve: false)
  elsif @status == "All"
    @workorders = Workorder.all
  else
  @workorders = EmployeesWorkorder.where(status: @status)
  end
end
  # PATCH/PUT /workorders/1
  # PATCH/PUT /workorders/1.json
  def update
    respond_to do |format|
    if @workorder.update(workorder_params)
      @workorder.fproducts.each do |f|
        f.measurements.each do |m|
          if !m.rate.present?
          
            if m.ftype == "Carcass Box"
              @rate1 = Rate.find_by(["product = ? and ptype = ? and ctype = ?",f.product,m.ftype,"Back" ])
            @rate2 = Rate.find_by(["product = ? and ptype = ? and ctype = ?",f.product,m.ftype,"TB/LR" ])
            m.update(back_rate: @rate1.price)
            m.update(rate: @rate2.price)
          else
            @rate1 = Rate.find_by(["product = ? and ptype = ?",f.product,m.ftype])
            m.update(rate: @rate1.price)
          end
        end
      end
    end


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
  def proforma_invoice
    @workorder = Workorder.find(params[:id])
    @qr = RQRCode::QRCode.new(@workorder.order_no, size: 4)
    @rates = Rate.all
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "proforma_invoice.pdf.erb" 
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
        response.headers['Content-Disposition'] = 'attachment;' "filename= \"#{@workorder.invoice_no}\".pdf"  # Excluding ".pdf" extension.
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

  def record_payment_workorder
    @workorder = Workorder.find(params[:id])

    if params[:params1].present?
      @workorder.update(add_price: params[:params1], rem_price: params[:params2])
    end
  end

  def end_time
    @end = params[:endtime]
    @employee_id = params[:employee_id]
    @workorder_id = params[:workorder_id]
    @emp_work =  EmployeesWorkorder.find_by(["employee_id = ? and workorder_id = ?",@employee_id,@workorder_id])
    @emp_work.update(endtime: @end)
    @emp_work.update(status: "Completed")
     @location = Employee.find(@employee_id).location_id
    if Employee.find(@employee_id).employee_type == "Pasting"

    @id = Employee.find_by(["employee_type = ? and location_id = ?", "Cutting",@location])
    elsif Employee.find(@employee_id).employee_type == "Cutting"
      @id = Employee.find_by(["employee_type = ? and location_id = ?", "Edge Binding",@location])
    elsif Employee.find(@employee_id).employee_type == "Edge Binding"
      @id = Employee.find_by(["employee_type = ? and location_id = ?", "Packing & Quality",@location])
    end

  EmployeesWorkorder.create(employee_id: @id.id,workorder_id: @workorder_id ,status: "Pending")



  end
 
  def add
    workorder = params[:workorder_id]
    if params[:measurement_id] != nil


      
     m = params[:measurement_id]
     id = m.to_i
     right = params[:right]
     right_color = params[:right_color]
     right_dark = params[:right_dark]
     right_light = params[:right_light]
     left = params[:left]
     left_color = params[:left_color]
     left_dark = params[:left_dark]
     left_light = params[:left_light]
     top = params[:top]
     top_color = params[:top_color]
     top_dark = params[:top_dark]
     top_light = params[:top_light]
     bottom = params[:bottom]
     bottom_color = params[:bottom_color]
     bottom_dark = params[:bottom_dark]
     bottom_light = params[:bottom_light]
     



     Additional.create(right: right , right_color: right_color,right_dark: right_dark,right_light: right_light,left: left , left_color: left_color,left_dark: left_dark,left_light: left_light,top: top , top_color: top_color,top_dark: top_dark,top_light: top_light,bottom: bottom , bottom_color: bottom_color,bottom_dark: bottom_dark,bottom_light: bottom_light,measurement_id: id)

    end

redirect_to workorder_path(workorder)
 end

def addition

  @colors = Color.all
  @m = Measurement.find(params[:measurement_id])
  @workorder = Workorder.find(params[:workorder_id])

  @additional = Additional.find_by(measurement_id: @m)


  #@additional = Additional.find_by(measurement_id: params[:measurement_id])
end

def update_additional
  m_id = params[:measurement_id]
  w_id = params[:workorder_id]

  @additional = Additional.find_by(measurement_id: m_id)
  @additional.update(additional_params)
  redirect_to workorder_path(w_id)
 
  
end

  def order_status
    @employee_workorders = EmployeesWorkorder.all
    @workorders = Workorder.all
  end

  def workorder_status
    @employee_workorders = EmployeesWorkorder.all
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
     params.require(:workorder).permit(:site_name,:total_to_pay,:g_section,:g_section_with_end_cap,:dark_color,:light_color,:delivered,:add_price,:rem_price,:order_no,:invoice_no,:color_id ,:date,:location_id , :employee_id,:remove_photo1,:remove_photo2,:remove_photo3,:remove_photo4,:remove_photo5 ,:vendor_id,:name1,:photo1,:name2,:photo2,:name3,:photo3,:name4,:photo4,:name5,:photo5,fproducts_attributes: [:id ,:product,:workorder_id,:_destroy ,measurements_attributes: [:id,:wh,:bsl_type,:ftype,:width,:height,:rate,:depth,:color_id,:side,:skirting,:horizontal,:vertical,:center,:total,:fproduct_id, :quantity,:glass_shutter,:handle,:handle_groove,:handle_fitting,:right,:right_dark,:right_light,:left,:left_dark,:left_light,:top,:top_dark,:top_light,:bottom,:bottom_dark,:bottom_light,:_destroy]])

   end
   def additional_params
    params.require(:additional).permit(:right,:payment_status,:right_color,:right_dark,:right_light,:left,:left_color,:left_dark,:left_light,:top,:top_color,:top_dark,:top_light,:bottom,:bottom_color,:bottom_dark,:bottom_light,:measurement_id)
 end
end
