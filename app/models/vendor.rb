class Vendor < ApplicationRecord
	has_many :deliveries
	validates :name, presence:true
end
