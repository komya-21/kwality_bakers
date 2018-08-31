	class Measurement < ApplicationRecord
  belongs_to :color,optional: :true
  belongs_to :fproduct
 
  
end
