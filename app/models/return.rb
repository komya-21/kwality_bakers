class Return < ApplicationRecord
  belongs_to :vendor
  belongs_to :inward_product , optional: true
  belongs_to :product
  validates :product, presence:true
  scope :list1, -> {where(return_type: 'OK')}
  scope :list2, -> {where(return_type: 'NOT-OK')}

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |return_module|
        csv << return_module.attributes.values_at(*column_names)
      end
    end
  end
end
