class Vendor < ApplicationRecord
	has_many :deliveries


def self.search(search)
    Vendor.where("name LIKE ?" , "%#{search}%")
  end
end
