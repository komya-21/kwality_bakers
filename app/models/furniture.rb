class Furniture < ApplicationRecord
	

	has_many :furniture_types
  accepts_nested_attributes_for :furniture_types, reject_if: :all_blank, allow_destroy: true, :update_only => true
end
