class Vendor < ApplicationRecord
	has_many :deliveries , dependent: :destroy


def self.search(search)
    Vendor.where("name LIKE ?" , "%#{search}%")
  end
end
