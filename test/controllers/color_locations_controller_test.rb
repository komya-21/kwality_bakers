require 'test_helper'

class ColorLocationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @color_location = color_locations(:one)
  end

  test "should get index" do
    get color_locations_url
    assert_response :success
  end

  test "should get new" do
    get new_color_location_url
    assert_response :success
  end

  test "should create color_location" do
    assert_difference('ColorLocation.count') do
      post color_locations_url, params: { color_location: { color_id: @color_location.color_id, located: @color_location.located } }
    end

    assert_redirected_to color_location_url(ColorLocation.last)
  end

  test "should show color_location" do
    get color_location_url(@color_location)
    assert_response :success
  end

  test "should get edit" do
    get edit_color_location_url(@color_location)
    assert_response :success
  end

  test "should update color_location" do
    patch color_location_url(@color_location), params: { color_location: { color_id: @color_location.color_id, located: @color_location.located } }
    assert_redirected_to color_location_url(@color_location)
  end

  test "should destroy color_location" do
    assert_difference('ColorLocation.count', -1) do
      delete color_location_url(@color_location)
    end

    assert_redirected_to color_locations_url
  end
end
