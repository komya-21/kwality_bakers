class ReturnsController < ApplicationController
  before_action :set_return, only: [:show, :edit, :update, :destroy]

  # GET /returns
  # GET /returns.json
  def index
    @returns = Return.all
     respond_to do |format|
        format.html
        format.csv { send_data @returns.to_csv }
        format.xls { send_data @returns.to_csv(col_sep: "\t") }
      end
     # @returns = Return.paginate(:page => params[:page], :per_page => 10)
  end  # GET /returns/1
  # GET /returns/1.json
  def show
    
  end 
   
  
def export_return
  @returns = Return.all
   respond_to do |format|
format.xlsx {
  response.headers['Content-Disposition'] = 'attachment;' "filename= Returns\"#{Date.today}\".xlsx"
}
end
end
  

  # GET /returns/new
  def new
    @return = Return.new

    @inwards = InwardProduct.all.map{|i| [i.product.name]}.to_a.uniq

  end

  # GET /returns/1/edit
  def edit
  end

  def return_type_report
  end

  def select_return_type
    @return_type = params[:return_type]
    if @return_type == 'OK'
      @returns = Return.list1
    elsif @return_type == 'NOT-OK'
      @returns = Return.list2
    else
      @returns = Return.all
    end 
  end

  # POST /returns
  # POST /returns.json
  def create
    @return = Return.new(return_params)

    respond_to do |format|
      if @return.save
        if @return.return_type == 'OK'
          @current = CurrentInventory.find_by(product_id: @return.product_id)
          @current.update(current_quantity: @current.current_quantity.to_i + @return.return_quantity.to_i)
        end

        format.html { redirect_to @return, notice: 'Return was successfully created.' }
        format.json { render :show, status: :created, location: @return }
      else
        format.html { render :new }
        format.json { render json: @return.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /returns/1
  # PATCH/PUT /returns/1.json
  def update
    respond_to do |format|
      if @return.update(return_params)
        format.html { redirect_to @return, notice: 'Return was successfully updated.' }
        format.json { render :show, status: :ok, location: @return }
      else
        format.html { render :edit }
        format.json { render json: @return.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /returns/1
  # DELETE /returns/1.json
  def destroy
    @return.destroy
    respond_to do |format|
      format.html { redirect_to returns_url, notice: 'Return was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_return
      @return = Return.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def return_params
      params.require(:return).permit(:date_of_return, :invoice_number, :vendor_id, :inward_product_id, :return_quantity, :purpose, :receipt_no, :return_type , :product_id)
    end
end
