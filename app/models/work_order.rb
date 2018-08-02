class WorkOrder < ApplicationRecord
  belongs_to :color ,optional: :true
end
