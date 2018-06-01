class CurrentInventory < ApplicationRecord
  belongs_to :inward_product , optional: :true
  belongs_to :delivery_inward , optional: :true
  belongs_to :product , optional: :true
end
