class WorkOrder < ApplicationRecord
  belongs_to :color ,optional: :true
  belongs_to :furniture , optional: :true
end
