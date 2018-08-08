class Workorder < ApplicationRecord
	has_many :fproducts ,inverse_of: :workorder,dependent: :destroy
	accepts_nested_attributes_for :fproducts
	# reject_if: proc{ |attributes| attributes[:answer].blank? }, allow_destroy: true
end
