class CurrentInventory < ApplicationRecord
  belongs_to :inward_product , optional: :true
  belongs_to :delivery_inward , optional: :true
  belongs_to :product , optional: :true

      def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |return_module|
        csv << return_module.attributes.values_at(*column_names)
      end
    end
end
end
