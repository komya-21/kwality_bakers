class Vendor < ApplicationRecord
	has_many :deliveries , dependent: :destroy
	validates :name, presence:true
	belongs_to :location,optional: true
	after_create :create_user
	has_many :workorders

	def create_user
		User.create(email: self.email , password: self.password ,vendor_id: self.id, role: "Vendor")
	end
end
