class TransactionDetail < ApplicationRecord
  belongs_to :inward,optional: true,dependent: :destroy
end
