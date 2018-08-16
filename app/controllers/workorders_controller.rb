class WorkordersController < ApplicationController
  before_action :set_workorder, only: [:show, :edit, :update, :destroy]

  # GET /workorders
  # GET /workorders.json
  def index
    if current_user.role == "SuperAdmin"
    @workorders = Workorder.all
  else
    @workorders = Workorder.where(vendor_id: current_user.vendor_id)
  end
    if params[:param1].present? && params[:param1] == 'false'
        workorder = Workorder.list(params[:id])
        workorder.update!(approve: true)

       
      elsif params[:param1].present? && params[:param1] == 'true'
          workorder = Workorder.list(params[:id])

         workorder.update!(approve: false) 
       
      
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
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workorder
      @workorder = Workorder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def workorder_params
     params.require(:workorder).permit(:order_no ,:date,:remove_photo1,:remove_photo2,:remove_photo3,:remove_photo4,:remove_photo5 ,:vendor_id,:name1,:photo1,:name2,:photo2,:name3,:photo3,:name4,:photo4,:name5,:photo5,fproducts_attributes: [:id ,:product,:workorder_id,:_destroy ,measurements_attributes: [:id,:ftype,:width,:height,:depth,:color_id,:side,:skirting,:horizontal,:vertical,:center,:total,:fproduct_id, :quantity,:_destroy]])

    end
end
