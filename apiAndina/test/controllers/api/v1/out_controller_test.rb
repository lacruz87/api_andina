require 'test_helper'

class Api::V1::OutControllerTest < ActionDispatch::IntegrationTest
  test "should get getRfidInfo" do
    get api_v1_out_getRfidInfo_url
    assert_response :success
  end

  test "should get getStock" do
    get api_v1_out_getStock_url
    assert_response :success
  end

  test "should get getPointZona" do
    get api_v1_out_getPointZona_url
    assert_response :success
  end

  test "should get getZona" do
    get api_v1_out_getZona_url
    assert_response :success
  end

end
