class InwardProduct < ApplicationRecord
  belongs_to :product
  belongs_to :inward, optional:true
end
