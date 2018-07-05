class Inward < ApplicationRecord
	has_many :inward_products, inverse_of: :inward, dependent: :destroy
  accepts_nested_attributes_for :inward_products, reject_if: :all_blank, allow_destroy: true, :update_only => true
  validates :inward_products, presence:true
  
  def self.inward_no
    date = Date.today.strftime('%Y%m%d')
    if Inward.first.nil?
      'INV' + date.to_s + '1'
    else
      last_id = Inward.last.id.next
      'INV' + date.to_s + last_id.to_s
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