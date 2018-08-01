require 'test_helper'

class WorkOrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @work_order = work_orders(:one)
  end

  test "should get index" do
    get work_orders_url
    assert_response :success
  end

  test "should get new" do
    get new_work_order_url
    assert_response :success
  end

  test "should create work_order" do
    assert_difference('WorkOrder.count') do
      post work_orders_url, params: { work_order: { center: @work_order.center, color_id: @work_order.color_id, depth: @work_order.depth, height: @work_order.height, horizontal: @work_order.horizontal, quantity: @work_order.quantity, side: @work_order.side, skirting: @work_order.skirting, total: @work_order.total, vertical: @work_order.vertical, width: @work_order.width } }
    end

    assert_redirected_to work_order_url(WorkOrder.last)
  end

  test "should show work_order" do
    get work_order_url(@work_order)
    assert_response :success
  end

  test "should get edit" do
    get edit_work_order_url(@work_order)
    assert_response :success
  end

  test "should update work_order" do
    patch work_order_url(@work_order), params: { work_order: { center: @work_order.center, color_id: @work_order.color_id, depth: @work_order.depth, height: @work_order.height, horizontal: @work_order.horizontal, quantity: @work_order.quantity, side: @work_order.side, skirting: @work_order.skirting, total: @work_order.total, vertical: @work_order.vertical, width: @work_order.width } }
    assert_redirected_to work_order_url(@work_order)
  end

  test "should destroy work_order" do
    assert_difference('WorkOrder.count', -1) do
      delete work_order_url(@work_order)
    end

    assert_redirected_to work_orders_url
  end
end
