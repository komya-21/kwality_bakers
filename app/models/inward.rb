class Inward < ApplicationRecord
	has_many :inward_products, inverse_of: :inward, dependent: :destroy
    accepts_nested_attributes_for :inward_products, reject_if: :all_blank, allow_destroy: true, :update_only => true

	def inward_no
    date = Date.today.strftime('%Y%m%d')
    self.inward_no = 'IN' + date.to_s + '1' if Inward.first.nil?
    self.inward_no = 'IN' + date.to_s + \
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
    

  


