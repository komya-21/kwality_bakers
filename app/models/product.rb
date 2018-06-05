class Product < ApplicationRecord
	after_create :add_product


	def add_product
		
		CurrentInventory.create(product_id: self.id , current_quantity: 0)
	end

end
