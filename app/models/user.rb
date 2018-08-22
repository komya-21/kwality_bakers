class User < ApplicationRecord
belongs_to :vendor , optional: :true
belongs_to :employee , optional: :true
belongs_to :location , optional: :true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
