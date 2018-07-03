class ReportsController < ApplicationController
	
	def new
	end

	def create
		
		@payment_status = params[:report][:return_type]
    @deliveries = Delivery.all

    if @payment_status == 'PAID'
      @returns = Delivery.list1
    elsif @payment_status == 'PENDING'
      @returns = Delivery.list2
    else
      @returns = Delivery.all
    end 
		@type = params[:report][:report_type]
		@products = Product.all
		@start_date = params[:report][:start_date].to_date
	    @end_date = params[:report][:end_date].to_date
		# @deliveries = Delivery.where(["created_at >= ? and created_at <= ?", @start_date, @end_date])
		@dates = @deliveries.all.map{|d| d.date}.to_a.uniq

		@return_modules = Return.where(["created_at >= ? and created_at <= ?", @start_date, @end_date])

		@inward_modules = InwardProduct.all

		@delivery_items = DeliveryInward.where(["created_at >= ? and created_at <= ?", @start_date, @end_date])
		@delivery_items.each do |d| 
		 @date = d.created_at.between?(@start_date , @end_date)
		 
		end 
		
		@delivery_ids = @delivery_items.all.map{|i| i.delivery_id}.to_a
		@uniq_delivery_items = @delivery_items.all.map{|i| [i.product.name,i.product_id , i.product.price , i.delivery.vendor.comission]}.to_a.uniq

		@delivery_qty = @delivery_items.all
	
		
	    @total_inwards = InwardProduct.where(["created_at >= ? and created_at <= ?", @start_date, @end_date])

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

	    @total_inwards = InwardProduct.where(["created_at >= ? and created_at <= ?", @start_date, @end_date])

end
def export_return

	@start_date = params[:start_date].to_date
	@end_date = params[:end_date].to_date

	    @return_modules= Return.where(["created_at >= ? and created_at <= ?", @start_date, @end_date])
end
def export_delivery
@start_date = params[:start_date].to_date
@end_date = params[:end_date].to_date
@delivery_items = DeliveryInward.where(["created_at >= ? and created_at <= ?", @start_date, @end_date])
@delivery_vendors = Vendor.all.map{|i| i.name}.to_a
@product = Product.all
@deliveries = Delivery.where(["created_at >= ? and created_at <= ?", @start_date, @end_date])

end
	 

end