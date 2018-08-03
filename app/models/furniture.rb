class Furniture < ApplicationRecord
	

	has_many :work_orders, inverse_of: :furniture, dependent: :destroy
  accepts_nested_attributes_for :work_orders, reject_if: :all_blank, allow_destroy: true, :update_only => true
end
