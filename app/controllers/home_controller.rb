class HomeController < ApplicationController
  def dashboard
  	@chart = LazyHighCharts::HighChart.new('graph') do |f|
  	@emp_type = Employee.find_by(employee_type: "Pasting")
  	@emp_type1 = Employee.find_by(employee_type: "Cutting")
  	@emp_type2 = Employee.find_by(employee_type: "Edge Binding")
	@emp_type3 = Employee.find_by(employee_type: "Packing & Quality")


	@pasting_record = EmployeesWorkorder.where(employee_id: @emp_type.id, status: 'Completed')

	@cutting_record = EmployeesWorkorder.where(employee_id: @emp_type1.id, status: 'Completed')
	@edge_record = EmployeesWorkorder.where(employee_id: @emp_type2.id, status: 'Completed')
	@pack_record = EmployeesWorkorder.where(employee_id: @emp_type3.id, status: 'Completed')


  	f.title(text: "Total WorkOrder Completed")
  	f.xAxis(categories: ["Pasting","Cutting","Edge Binging","Packing & Quality"])
  	f.series(name: "Workorder Completed Count", yAxis: 0, data: [@pasting_record.count, @cutting_record.count, @edge_record.count, @pack_record.count])

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
    width: 573,
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
end
  
end
