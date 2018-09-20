class HomeController < ApplicationController
  def dashboard
    @emp_work =  EmpWork.find_by(employee_id: current_user.employee_id)

  	@chart = LazyHighCharts::HighChart.new('graph') do |f|
  	@emp_type = Employee.where(employee_type: "Pasting")
  	@emp_type1 = Employee.where(employee_type: "Cutting")
  	@emp_type2 = Employee.where(employee_type: "Edge Binding")
    @emp_type3 = Employee.where(employee_type: "Packing & Quality")
    @a = 0
  @emp_type.each do |e|
	@pasting_record = EmployeesWorkorder.where(employee_id: e.id, status: 'Completed')
  @a += @pasting_record.count
  end

  @b = 0
  @emp_type1.each do |e|
	@cutting_record = EmployeesWorkorder.where(employee_id: e.id, status: 'Completed')
  @b += @cutting_record.count
end
@c = 0
@emp_type2.each do |e|
	@edge_record = EmployeesWorkorder.where(employee_id: e.id, status: 'Completed')
  @c += @edge_record.count
end
@d = 0
@emp_type3.each do |e|
	@pack_record = EmployeesWorkorder.where(employee_id: e.id, status: 'Completed')
  @d += @pack_record.count
end


  	f.title(text: "Total WorkOrder Completed")
  	f.xAxis(categories: ["Pasting","Cutting","Edge Binging","Packing & Quality"])
  	f.series(name: "Workorder Completed Count", yAxis: 0, data: [@a, @b, @c, @d])

  	f.yAxis [
    	{title: {text: "Workorder", margin: 70} },
    	{title: {text: "Completed Work"}, opposite: true},
  	]

  	f.legend(align: 'right', verticalAlign: 'top', y: 75, x: -50, layout: 'vertical')
  	f.chart({defaultSeriesType: "column"})
  end

@chart_globals = LazyHighCharts::HighChartGlobals.new do |f|
  f.global(useUTC: false)
  f.chart(
    backgroundColor: {
      linearGradient: [0, 0, 500, 500],
      stops: [
        [0, "rgb(240, 240, 255)"]
      ]
    },
    borderWidth: 0,
    plotBackgroundColor: "rgba(255, 255, 255, .9)",
    BackgroundColor: "#fff",
    plotShadow: true,
    plotBorderWidth: 0,
    width: 545,
    height: 300
  )
  f.lang(thousandsSep: ",")
  f.colors(["#90ed7d", "#f7a35c", "#8085e9", "#f15c80", "#e4d354"])
end

  @hi = LazyHighCharts::HighChart.new('graph') do |f|
      f.options[:chart][:defaultSeriesType] = "pie"
      f.options[:title][:text] = "Payment Status"

      
        #f.series(:name=>"Pending", :data=>[:name=>"pending", :y=>10])
        f.series(:name=>"Paid", :data=>[:name=>"paid", :y=>12])
      
end
@chart_teste5 = LazyHighCharts::HighChart.new('graph') do |f|
   @totl = 0
   @p_amt = 0
   @workorders = Workorder.all
 @workorders.each do |pd|
 
 if pd.rem_price == nil
 @p_amt += pd.total_to_pay.to_f.ceil
 elsif pd.rem_price != "0"
 @p_amt += pd.rem_price.to_i
 end
 end
 @paid1 = @workorders.where(payment_status: true)
@paid1.each do |p|
  @total_paid = p.total_to_pay.to_f.ceil
  @totl += @total_paid
  end

  f.chart({:defaultSeriesType=>"pie", :margin=> [50, 0, 0, 0]})
  f.title({:text => "Payment"})
  f.subtitle({:text => "Payment Status"})
  f.series({
    :type => "pie",
    :name => "Payment",
    :size => "80%",
    :innerSize => "20%",
    :data => [{ :name => "Pending", :y => @p_amt, :color =>"#80699B" },{ :name => "Paid", :y => @totl, :color => "#3D96AE" }],
    :dataLabels=> { :enabled => true }
  }
  )
end
end
  
end
