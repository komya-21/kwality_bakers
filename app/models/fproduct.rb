class Fproduct < ApplicationRecord
   belongs_to :workorder,optional: :true
   has_many :measurements, inverse_of: :fproduct,dependent: :destroy
   accepts_nested_attributes_for :measurements
end
