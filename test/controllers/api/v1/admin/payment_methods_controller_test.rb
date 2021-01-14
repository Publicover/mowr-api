require 'test_helper'

class Api::V1::Admin::PaymentMethodsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_admin_payment_methods_index_url
    assert_response :success
  end

  test "should get show" do
    get api_v1_admin_payment_methods_show_url
    assert_response :success
  end

  test "should get create" do
    get api_v1_admin_payment_methods_create_url
    assert_response :success
  end

  test "should get update" do
    get api_v1_admin_payment_methods_update_url
    assert_response :success
  end

  test "should get destroy" do
    get api_v1_admin_payment_methods_destroy_url
    assert_response :success
  end

end
