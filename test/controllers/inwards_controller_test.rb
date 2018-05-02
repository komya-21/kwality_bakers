require 'test_helper'

class InwardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @inward = inwards(:one)
  end

  test "should get index" do
    get inwards_url
    assert_response :success
  end

  test "should get new" do
    get new_inward_url
    assert_response :success
  end

  test "should create inward" do
    assert_difference('Inward.count') do
      post inwards_url, params: { inward: { date: @inward.date, inward_no: @inward.inward_no } }
    end

    assert_redirected_to inward_url(Inward.last)
  end

  test "should show inward" do
    get inward_url(@inward)
    assert_response :success
  end

  test "should get edit" do
    get edit_inward_url(@inward)
    assert_response :success
  end

  test "should update inward" do
    patch inward_url(@inward), params: { inward: { date: @inward.date, inward_no: @inward.inward_no } }
    assert_redirected_to inward_url(@inward)
  end

  test "should destroy inward" do
    assert_difference('Inward.count', -1) do
      delete inward_url(@inward)
    end

    assert_redirected_to inwards_url
  end
end
