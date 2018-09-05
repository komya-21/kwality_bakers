class Workorder < ApplicationRecord
	attr_accessor :remove_photo1
	attr_accessor :remove_photo2
	attr_accessor :remove_photo3
	attr_accessor :remove_photo4
	attr_accessor :remove_photo5
	
	
	before_save :delete_photo1, if: ->{ remove_photo1 == '1' && !photo1_updated_at_changed? }

	before_save :delete_photo2, if: ->{ remove_photo2 == '1' && !photo2_updated_at_changed? }
	before_save :delete_photo3, if: ->{ remove_photo3 == '1' && !photo3_updated_at_changed? }
	before_save :delete_photo4, if: ->{ remove_photo4 == '1' && !photo4_updated_at_changed? }
	before_save :delete_photo5, if: ->{ remove_photo5 == '1' && !photo5_updated_at_changed? }
 
	belongs_to :vendor , optional: :true
	belongs_to :location , optional: :true
	has_and_belongs_to_many :employees
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

  scope :list1, -> {where(payment_status: true)}
  scope :list2, -> {where(payment_status: false)}

  scope :list, ->(id) { where(id: id).take }

  
  
  private

  def delete_photo1
  
    self.photo1 = nil
  end
  def delete_photo2
  	
    self.photo2 = nil
  end
  def delete_photo3
  	
    self.photo3 = nil
  end
  def delete_photo4
  	
    self.photo4 = nil
  end
  def delete_photo5
  	
    self.photo5 = nil
  end

	# reject_if: proc{ |attributes| attributes[:answer].blank? }, allow_destroy: true
end
