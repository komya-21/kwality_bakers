class Delivery < ApplicationRecord
  belongs_to :vendor, optional:true
  validates :vendor, presence:true
  validates :delivery_inwards, :presence => true
   has_many :delivery_inwards, inverse_of: :delivery, dependent: :destroy
  accepts_nested_attributes_for :delivery_inwards, reject_if: :all_blank, allow_destroy: true, :update_only => true
  scope :list1, -> {where(payment_status: true)}
  scope :list2, -> {where(payment_status: false)}

  def self.invoice_no
    date = Date.today.strftime('%Y%m%d')
    if Delivery.first.nil?
      'D' + date.to_s + '1'
    else
      last_id = Delivery.last.id.next
      'D' + date.to_s + last_id.to_s
    end
  end


    def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |return_module|
        csv << return_module.attributes.values_at(*column_names)
      end
    end
end

end
