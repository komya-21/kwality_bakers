class CurrentInventoriesController < ApplicationController
	def create
		@current_inventory = CurrentInventory.new(current_inventory_params)
	end
	def current_inventory_params
		params.require(:current_inventories).permit!
	end
end
