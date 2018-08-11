class Workorder < ApplicationRecord
	belongs_to :vendor , optional: :true
	has_many :fproducts ,inverse_of: :workorder,dependent: :destroy
	accepts_nested_attributes_for :fproducts


	has_attached_file :photo1,:url => "/assets/workorders/:id/:style/:basename.:extension",
							  :path => ":rails_root/public/assets/workorders/:id/:style/:basename.:extension"

	has_attached_file :photo2,:url => "/assets/workorders/:id/:style/:basename.:extension",
							  :path => ":rails_root/public/assets/workorders/:id/:style/:basename.:extension"
							  
	has_attached_file :photo3,:url => "/assets/workorders/:id/:style/:basename.:extension",
							  :path => ":rails_root/public/assets/workorders/:id/:style/:basename.:extension"
							  
	has_attached_file :photo4,:url => "/assets/workorders/:id/:style/:basename.:extension",
							  :path => ":rails_root/public/assets/workorders/:id/:style/:basename.:extension"
							  
	has_attached_file :photo5,:url => "/assets/workorders/:id/:style/:basename.:extension",
							  :path => ":rails_root/public/assets/workorders/:id/:style/:basename.:extension"
							  

	validates_attachment_content_type :photo1, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
	validates_attachment_content_type :photo2, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
	validates_attachment_content_type :photo3, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
	validates_attachment_content_type :photo4, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
	validates_attachment_content_type :photo5, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

	


	 def order_num
    date = Date.today.strftime('%Y%m%d')
     if Workorder.first.nil?
    self.order_no = "GE"+date.to_s + '1'
else
    self.order_no = "GE"+date.to_s + \
                          Workorder.last.id.next.to_s
                      end
  end

  scope :list, ->(id) { where(id: id).take }
	# reject_if: proc{ |attributes| attributes[:answer].blank? }, allow_destroy: true
end
