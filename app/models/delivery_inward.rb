class DeliveryInward < ApplicationRecord
  belongs_to :delivery
  belongs_to :inward_product, optional:true
  belongs_to :product ,optional:true
  validates :qty, presence:true
  belongs_to :vendor ,optional:true
end
