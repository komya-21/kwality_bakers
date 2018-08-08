class WorkOrder < ApplicationRecord
  belongs_to :color ,optional: :true
  belongs_to :furniture_type , optional: :true
end
