class PayslipsController < ApplicationController
  before_action :set_payslip, only: [:show, :edit, :update, :destroy]

  # GET /payslips
  # GET /payslips.json
  def index
    @payslips = Payslip.all
  end

  # GET /payslips/1
  # GET /payslips/1.json
  def show
    @earnings = Earning.all
    @deductions = Deduction.all
  end
  def employee_payslip
    @salary_dates = Payslip.all.map{|p| [p.date.strftime("%B %Y")]}.uniq
   
    @employees = Employee.all
  end
  # GET /payslips/new
  def new
    @payslip = Payslip.new
    @employee_id = params[:employee_id]

    
  end
  def select_emp
    @employee_id = params[:employee]
    @date = params[:salary_date]
    
    
    @payslip_emp = Payslip.find_by(month_year: @date,employee_id: @employee_id)

    @earnings = Earning.all
    @deductions = Deduction.all
   
      #@d = @payslips.date.strftime("%d-%m-%Y").split("-")
   
   
  end
  def payslip_pdf
    @payslip = Payslip.find(params[:id])
    @earnings = Earning.all
    @deductions = Deduction.all
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "payslip_pdf.pdf.erb" 
        response.headers['Content-Disposition'] = 'attachment;' "filename= Payslip.pdf"  # Excluding ".pdf" extension.
      end
    end
  end

  def monthly_payslip
    #@monthly_payslip = Payslip.find(params[:id])
  end

  def employees
    @employees = Employee.all
  end


  # GET /payslips/1/edit
  def edit
  end

  # POST /payslips
  # POST /payslips.json
  def create
    @payslip = Payslip.new(payslip_params)
    

    respond_to do |format|
      if @payslip.save
        @payslip.update(month_year: @payslip.date.strftime("%B %Y"))
        format.html { redirect_to @payslip, notice: 'Payslip was successfully created.' }
        format.json { render :show, status: :created, location: @payslip }
      else
        format.html { render :new }
        format.json { render json: @payslip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payslips/1
  # PATCH/PUT /payslips/1.json
  def update
    respond_to do |format|
      if @payslip.update(payslip_params)
        format.html { redirect_to @payslip, notice: 'Payslip was successfully updated.' }
        format.json { render :show, status: :ok, location: @payslip }
      else
        format.html { render :edit }
        format.json { render json: @payslip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payslips/1
  # DELETE /payslips/1.json
  def destroy
    @payslip.destroy
    respond_to do |format|
      format.html { redirect_to payslips_url, notice: 'Payslip was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payslip
      @payslip = Payslip.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payslip_params
      params.require(:payslip).permit(:employee_id,:month_year, :earning_id, :deduction_id, :date, :basic_salary,:gross_salary,:net_salary)
    end
end
