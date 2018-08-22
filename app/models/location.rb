class Location < ApplicationRecord
has_many :vendors
	def self.set_location_code
	date = Date.today.strftime('%Y%m%d')
		if Location.first.nil?
			'C' + date.to_s + '1'
		else
			last_id = Location.last.id.next
			'C' + date.to_s + last_id.to_s
		end
	end
	after_create :create_user
	def create_user

		User.create(email: self.email , password: self.code,role: "Center",location_id: self.id)
	end
end
