class InwardsController < ApplicationController
  before_action :set_inward, only: [:show, :edit, :update, :destroy]

  # GET /inwards
  # GET /inwards.json
  def index
    @inwards = Inward.all
     respond_to do |format|
        format.html
        format.csv { send_data @inwards.to_csv }
        format.xls { send_data @inwards.to_csv(col_sep: "\t") }
        end
        #@inwards = Inward.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /inwards/1
  # GET /inwards/1.json
  def show
    
  end

  def stock
    @inwards = Inward.all
    @inward_products = InwardProduct.all
    @qua = InwardProduct.search(params[:search])
    @current_inventories = CurrentInventory.all
    respond_to do |format|
        format.html
        format.csv { send_data @current_inventories.to_csv }
        format.xls { send_data @current_inventories.to_csv(col_sep: "\t") }
    end
  end


  #load product on ajax call to fetch rate
  def load_item_data

  
    @product = CurrentInventory.find_by(product_id: params[:product_id])
  
  
    render :json => [@product.product.price, @product.current_quantity,@product.product.unit]
  end

  # GET /inwards/new
  def new
    @inward = Inward.new
    @inward.inward_no = Inward.inward_no
  end

  # GET /inwards/1/edit
  def edit
  end

  def inward_record_payment
    @inward = Inward.find(params[:id])
    if params[:params1].present?
      @inward.update(add_price: params[:params1], rem_price: params[:params2])
    end

  end

  def transaction_detail
   inward_id = params[:inward_id]
   rem_price = Inward.find(inward_id).rem_price
   payment_mode = params[:payment_mode]
   bank_name = params[:bank_name]
   cheque_no = params[:cheque_no]
    if payment_mode == "Cash"
      TransactionDetail.create(date: Date.today ,inward_id: inward_id,payment_mode: "Cash")
    else
      TransactionDetail.create(date: Date.today,inward_id: inward_id,payment_mode: "Cheque",bank_name: bank_name,cheque_no: cheque_no)
    end
  end

  # POST /inwards
  # POST /inwards.json
  def create
       @inward = Inward.new(inward_params)
       @inward_products = InwardProduct.all
          respond_to do |format|
          if @inward.save
           @inward.inward_products.each do |ip|
            @current = CurrentInventory.find_by(product_id: ip.product_id)
            
          
            @current.update(current_quantity: @current.current_quantity.to_i+ip.quantity.to_i)
          end

            format.html { redirect_to @inward, notice: 'Inward was successfully created.' }
            format.json { render :show, status: :created, location: @inward }
          else
                  format.html { render :new }
                  format.json { render json: @inward.errors, status: :unprocessable_entity }
          end
      end
  end
    

  # PATCH/PUT /inwards/1
  # PATCH/PUT /inwards/1.json
  def update
    respond_to do |format|
      if @inward.update(inward_params)
        format.html { redirect_to @inward, notice: 'Inward was successfully updated.' }
        format.json { render :show, status: :ok, location: @inward }
      else
        format.html { render :edit }
        format.json { render json: @inward.errors, status: :unprocessable_entity }
      end
    end
  end
def export_inward
  @total_inwards = InwardProduct.all
   respond_to do |format|
format.xlsx {
  response.headers['Content-Disposition'] = 'attachment;' "filename= Inward\"#{Date.today}\".xlsx"
}
end
end
  # DELETE /inwards/1
  # DELETE /inwards/1.json
  def destroy
    @inward.destroy
    respond_to do |format|
      format.html { redirect_to inwards_url, notice: 'Inward was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def inward_transaction_detail
    @inward_transaction_detail = TransactionDetail.find_by(inward_id: params[:inward_id])

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inward
      @inward = Inward.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inward_params
      params.require(:inward).permit(:date, :inward_no ,:total_to_pay,:add_price,:rem_price,:supplier_id,inward_products_attributes: [:id, :updated_quantity ,:product_id, :quantity, :inward_id,:total_quantity ,:width,:height,:category,:color_id,:unit, :price,:_destroy])
    end
end
