class InwardProduct < ApplicationRecord
  belongs_to :product
  belongs_to :color , optional: true
  belongs_to :inward, optional:true


  def self.search(search)

    InwardProduct.where("product.name LIKE ?" , "%#{search}%")
end




end
