class ReportsController < ApplicationController
	
	def new
	end

	def create
		
	@payment_status = params[:report][:return_type]
    
    @vendors = Vendor.all
    if @payment_status == 'PAID'
      @returns = Delivery.list1
    elsif @payment_status == 'PENDING'
      @returns = Delivery.list2
    else
      @returns = Delivery.all
    end 

    @inward_modules = InwardProduct.all
		@type = params[:report][:report_type]
		@products = Product.all
		@start_date = params[:report][:start_date].to_date
	    @end_date = params[:report][:end_date].to_date
		
		@return_modules = Return.where(date_of_return: @start_date.to_date..@end_date.to_date)

		@delivery_inwards = DeliveryInward.all
		@deliveries = Delivery.where(date: @start_date.to_date..@end_date.to_date)
		 
		@delivery_items = DeliveryInward.where(created_at: @start_date.to_date.midnight..@end_date.to_date.end_of_day)
		
		@inwards = Inward.where(date: @start_date.to_date..@end_date.to_date)
		
	    @total_inwards = InwardProduct.where(created_at: @start_date.to_date.midnight..@end_date.to_date.end_of_day)
	
	    if @start_date.nil? || @end_date.nil?
         flash[:alert] = 'Done'
         render 'new'
      end
      respond_to do |format|
        format.html
        format.csv { send_data @inward_modules.to_csv }
        format.xls { send_data @inward_modules.to_csv(col_sep: "\t") }
        end
	end
def export
	
	@start_date = params[:start_date].to_date
	@end_date = params[:end_date].to_date
	@inwards = Inward.where(date: @start_date.to_date..@end_date.to_date)
	#@total_inwards = InwardProduct.where(created_at: @start_date.to_date.midnight..@end_date.to_date.end_of_day)
		
respond_to do |format|
format.xlsx {
  response.headers['Content-Disposition'] = 'attachment;' "filename= Inwards\"#{Date.today}\".xlsx"
}
end
end

def export_return

	@start_date = params[:start_date].to_date
	@end_date = params[:end_date].to_date
	
		@return_modules= Return.where(date_of_return: @start_date.to_date..@end_date.to_date)
	
	respond_to do |format|
		format.xlsx {
  		response.headers['Content-Disposition'] = 'attachment;' "filename= Returns\"#{Date.today}\".xlsx"
}
end
end

def export_delivery
@start_date = params[:start_date].to_date
@end_date = params[:end_date].to_date
@delivery_inwards = DeliveryInward.all
@deliveries = Delivery.all
@vendors = Vendor.all




	@delivery_items = DeliveryInward.all
	@deliveries = Delivery.where(date: @start_date.to_date..@end_date.to_date)


@delivery_vendors = Vendor.all.map{|i| i.name}.to_a
@products = Product.all.order(:id)
@delivery_inwards = DeliveryInward.all
respond_to do |format|
format.xlsx {
  response.headers['Content-Disposition'] = 'attachment;' "filename= Delivery\"#{Date.today}\".xlsx"
}
end


end
def export_custom
	@start_date = params[:start_date].to_date
	@end_date = params[:end_date].to_date
	
		@deliveries = Delivery.where(date: @start_date.to_date..@end_date.to_date)
	
	
	respond_to do |format|
format.xlsx {
  response.headers['Content-Disposition'] = 'attachment;' "filename= Custom_Delivery\"#{Date.today}\".xlsx"
}
end
end
	def export_regular
		@start_date = params[:start_date].to_date
		@end_date = params[:end_date].to_date
		
		@deliveries = Delivery.where(date: @start_date.to_date..@end_date.to_date)	
		respond_to do |format|
format.xlsx {
  response.headers['Content-Disposition'] = 'attachment;' "filename= Regular_Delivery\"#{Date.today}\".xlsx"
}
end
	end

	def export_all_vendor
		@start_date = params[:start_date].to_date
		@end_date = params[:end_date].to_date
		
		@deliveries = Delivery.where(date: @start_date.to_date..@end_date.to_date)	
		respond_to do |format|
format.xlsx {
  response.headers['Content-Disposition'] = 'attachment;' "filename= All_Delivery\"#{Date.today}\".xlsx"
}
end
	end
	 

end