class Vendor < ApplicationRecord
	has_many :deliveries , dependent: :destroy
	validates :name, presence:true

	after_create :create_user

	def create_user
		User.create(email: self.email , password: self.password , role: "Vendor")
	end
end
