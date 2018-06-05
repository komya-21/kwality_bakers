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
        @inwards = Inward.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /inwards/1
  # GET /inwards/1.json
  def show
    
  end

  def stock
    @inwards = Inward.all
    @inward_products = InwardProduct.all
    @inwards = Inward.paginate(:page => params[:page], :per_page => 10)
    @qua = InwardProduct.search(params[:search])
    @current_inventories = CurrentInventory.all
    respond_to do |format|
        format.html
        format.csv { send_data @current_inventories.to_csv }
        format.xls { send_data @current_inventories.to_csv(col_sep: "\t") }
    end
            @current_inventories = CurrentInventory.paginate(:page => params[:page], :per_page => 10)
  end


  #load product on ajax call to fetch rate
  def load_item_data

  
    @product = CurrentInventory.find_by(product_id: params[:product_id])
  
   
    render :json => [@product.product.price, @product.current_quantity]
  end

  # GET /inwards/new
  def new
    @inward = Inward.new
    @inward.inward_no

  end

  # GET /inwards/1/edit
  def edit
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

  # DELETE /inwards/1
  # DELETE /inwards/1.json
  def destroy
    @inward.destroy
    respond_to do |format|
      format.html { redirect_to inwards_url, notice: 'Inward was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inward
      @inward = Inward.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inward_params
      params.require(:inward).permit(:date, :inward_no ,inward_products_attributes: [:id, :updated_quantity ,:product_id, :quantity, :inward_id,:total_quantity , :_destroy])
    end
end
