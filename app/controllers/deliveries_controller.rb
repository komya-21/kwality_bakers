class DeliveriesController < ApplicationController
  before_action :set_delivery, only: [:show, :edit, :update, :destroy, :record_payment, :payment]

  # GET /deliveries
  # GET /deliveries.json
  def index
    @deliveries = Delivery.all
     respond_to do |format|
        format.html
        format.csv { send_data @deliveries.to_csv }
        format.xls { send_data @deliveries.to_csv(col_sep: "\t") }
        end
        #@deliveries = Delivery.paginate(:page => params[:page], :per_page => 10)
  end

  def new_delivery
    
  end

  def select_vendor
      @vendor = Vendor.find(params[:vendor_id])
      @vendors = @vendor.deliveries
      @total = @vendor.deliveries.count
  end

  # GET /deliveries/1
  # GET /deliveries/1.json
  def show
  end

  # GET /deliveries/new
  def new
    @delivery = Delivery.new
    @delivery.invoice_no = Delivery.invoice_no
  end

  # GET /deliveries/1/edit
  def edit
  end

  def todays_delivery
    @deliveries = Delivery.where(created_at: Date.today.midnight..Date.today.end_of_day)
  end

  def export_delivery_index
    @deliveries = Delivery.all
    respond_to do |format|
    format.xlsx {
    response.headers['Content-Disposition'] = 'attachment;' "filename= All_Deliveries\"#{Date.today}\".xlsx"
    }
    end
  end
  #record payment
  def record_payment
    if params[:params1].present?
      @delivery.update(add_price: params[:params1], remaining_price: params[:params2])
    end
     respond_to do |format|
      format.html
      format.pdf do
        render pdf: "payment.pdf.erb" ,
        orientation: 'Landscape'   # Excluding ".pdf" extension.
      end
    end
  end

  def record_payment_all
    @deliveries = Delivery.all
  end

  def payment
      respond_to do |format|
      format.html
      format.pdf do
        render pdf: "payment.pdf.erb"   # Excluding ".pdf" extension.
      end
    end
  end

  # POST /deliveries
  # POST /deliveries.json
  def create
    @delivery = Delivery.new(delivery_params)
    @inward_products = InwardProduct.all
    respond_to do |format|
      if @delivery.save
        @delivery.delivery_inwards.update(vendor_id: @delivery.vendor_id)
        @delivery.delivery_inwards.each do |di|
        di.update(vendor_id: di.delivery.vendor_id)
      end
    @delivery.delivery_inwards.each do |d|
    @current = CurrentInventory.find_by(product_id: d.product_id)
    @current.update(current_quantity: d.rem_quantity)
    end
    format.html { redirect_to @delivery, notice: 'Delivery was successfully created.' }
    format.json { render :show, status: :created, location: @delivery }
    else
        format.html { render :new }
        format.json { render json: @delivery.errors, status: :unprocessable_entity }
    end
     end
  end


  # PATCH/PUT /deliveries/1
  # PATCH/PUT /deliveries/1.json
  def update
    respond_to do |format|
      if @delivery.update(delivery_params)
        format.html { redirect_to @delivery, notice: 'Delivery was successfully updated.' }
        format.json { render :show, status: :ok, location: @delivery }
      else
        format.html { render :edit }
        format.json { render json: @delivery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deliveries/1
  # DELETE /deliveries/1.json
  def destroy
    @delivery.destroy
    respond_to do |format|
      format.html { redirect_to deliveries_url, notice: 'Delivery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def payment_status_report
     
    @payment_status = params[:vendor_id]
   

    if @payment_status == 'PAID'
         

      @returns = Delivery.list1
    elsif @payment_status == 'PENDING'
      @returns = Delivery.list2
    else
      @returns = Delivery.all
    end 
  end
  def export_payment

     
   @payment_status = params[:payment_status]
   
  

    if @payment_status == "PAID"
         

      @returns = Delivery.list1
    elsif @payment_status == 'PENDING'
      @returns = Delivery.list2
    else
      @returns = Delivery.all
    end 
    respond_to do |format|
format.xlsx {
  response.headers['Content-Disposition'] = 'attachment;' "filename= \"#{@payment_status}\"(payment_report)\"#{Date.today}\".xlsx"
}
end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_delivery
      @delivery = Delivery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def delivery_params
      params.require(:delivery).permit(:invoice_no, :date, :vendor_id, :bill_checked_by, delivery_inwards_attributes:[:id , :inward_product_id, :product_id, :delivery_id, :quantity, :qty, :total_amt ,:rem_quantity, :_destroy , :price ,:gst ,:total])
    end
end