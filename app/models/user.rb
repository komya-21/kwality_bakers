class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  belongs_to :location,optional: :true
  belongs_to :employee,optional: :true
  belongs_to :vendor,optional: :true

devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

before_save :ensure_authentication_token

def skip_confirmation!
  self.confirmed_at = Time.now
end
end
