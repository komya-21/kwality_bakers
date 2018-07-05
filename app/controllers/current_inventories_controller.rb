class CurrentInventoriesController < ApplicationController
	def create
		@current_inventory = CurrentInventory.new(current_inventory_params)
	end
	
	def edit
		@current_inventory = CurrentInventory.find(params[:id])
		
	end
	def show

		@current_inventory = CurrentInventory.find(params[:id])

	end
	 def update
	 	
	 	@current_inventory = CurrentInventory.find(params[:id])
    	respond_to do |format|
      if @current_inventory.update(current_inventory_params)
        format.html { redirect_to "/inwards/stock", notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @current_inventory }
      else
        format.html { render :edit }
        format.json { render json: @current_inventory.errors, status: :unprocessable_entity }
      end
    end
  end
  
  	def destroy
  	@current_inventory = CurrentInventory.find(params[:id])

    @current_inventory.destroy
    respond_to do |format|
      format.html { redirect_to stock_inwards_path, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def reset
  	@current_inventory = CurrentInventory.find(params[:id])
  	 if @current_inventory.update(current_quantity: 0)
  	 	redirect_to "/inwards/stock"
        
      end

  end
  def reset_all
  	@current_inventories = CurrentInventory.all
  	@reset_entries = @current_inventories.where(["current_quantity > ?","0"])
  	

  	if @reset_entries.update(current_quantity: 0)
  	redirect_to "/inwards/stock"
  end
  end

	def current_inventory_params
		params.require(:current_inventory).permit(:product_id , :current_quantity)
	end
	def export_stock
		@current_inventories = CurrentInventory.all
	end
end
