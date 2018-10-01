class Measurement < ApplicationRecord
  belongs_to :color,optional: :true
  belongs_to :fproduct
 

  belongs_to :workorder,optional: :true
  
end
