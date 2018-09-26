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
		@workorders = Workorder.where(date: @start_date.to_date..@end_date.to_date).order(date: :desc)
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

def export_workorder

	@start_date = params[:start_date].to_date
	@end_date = params[:end_date].to_date

	@type = params[:return_type]

	@workorders = Workorder.where(date: @start_date.to_date..@end_date.to_date).order(date: :desc)
	@inwards = Inward.where(date: @start_date.to_date..@end_date.to_date)
 if @type == "Workorder"
	respond_to do |format|
		format.xlsx {
  		response.headers['Content-Disposition'] = 'attachment;' "filename= Workorders\"#{Date.today}\".xlsx"
}
end
elsif @type == "Payment"
	respond_to do |format|
		format.xlsx {
  		response.headers['Content-Disposition'] = 'attachment;' "filename= Payment\"#{Date.today}\".xlsx"
}
end
elsif @type == "Inward"
	respond_to do |format|
		format.xlsx {
  		response.headers['Content-Disposition'] = 'attachment;' "filename= Inwards\"#{Date.today}\".xlsx"
}
end
end




end

def export_locations_report
	@location = params[:location]
	@location_name = Location.find(@location).name
	@report_type = params[:report_type]
if (@report_type == "Workorders")
  @workorders = Workorder.where(location_id: @location)
elsif @report_type == "Employees"
  @employees = Employee.where(location_id: @location)
elsif @report_type == "Vendors"
  @vendors = Vendor.where(location_id: @location)
else
  #@emp_workorders = EmployeesWorkorder.all
  @workorders = Workorder.where(location_id: @location)
end
   respond_to do |format|
		format.xlsx {
  		response.headers['Content-Disposition'] = 'attachment;' "filename= \"#{@location_name}_#{@report_type}_#{Date.today}\".xlsx"
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



def	export_payment_status

	@payment_status = params[:payment_status]
	@vendor_id = params[:vendor_id]
	@workorders = Workorder.where(vendor_id: @vendor_id)
   

    if @payment_status == 'PAID'
         

      @returns = Workorder.list1
    elsif @payment_status == 'PENDING'
      @returns = Workorder.list2
    else
      @returns = Workorder.all
    end 

    respond_to do |format|
format.xlsx {
  response.headers['Content-Disposition'] = 'attachment;' "filename= Payment_Status\"#{Date.today}\".xlsx"
}
end
end	 
  

  def export_workorder_status
  	@status = params[:status]
  	 if @status == "Not Approved"
    @workorders = Workorder.where(approve: false)
  elsif @status == "All"
    @workorders = Workorder.all
  else
  @workorders = EmployeesWorkorder.where(status: @status)
  end
   respond_to do |format|
format.xlsx {
  response.headers['Content-Disposition'] = 'attachment;' "filename= Workorder_Status\"#{Date.today}\".xlsx"
}
end
  end
end