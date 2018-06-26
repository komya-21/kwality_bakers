class Vendor < ApplicationRecord
	has_many :deliveries , dependent: :destroy
	validates :name, presence:true
end