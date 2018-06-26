class Delivery < ApplicationRecord
  belongs_to :vendor, optional:true
   has_many :delivery_inwards, inverse_of: :delivery, dependent: :destroy
  accepts_nested_attributes_for :delivery_inwards, reject_if: :all_blank, allow_destroy: true, :update_only => true
  scope :list1, -> {where(payment_status: true)}
  scope :list2, -> {where(payment_status: false)}
	def invoice_no
    date = Date.today.strftime('%Y%m%d')
    self.invoice_no = 'INV' + date.to_s + '1' if Inward.first.nil?
    self.invoice_no = 'INV' + date.to_s + \
                          Inward.last.id.next.to_s unless Inward.first.nil?
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
