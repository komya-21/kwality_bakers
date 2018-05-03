class ReportsController < ApplicationController
	
	def new
	end

	def create
		@type = params[:report][:report_type]
		@deliveries = Delivery.all
		@return_modules = Return.all
		@inward_modules = InwardProduct.all
		@delivery_items = DeliveryInward.all
		@start_date = params[:report][:start_date].to_date
	    @end_date = params[:report][:end_date].to_date
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
end