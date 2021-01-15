# require 'test_helper'
#
# class Api::V1::Admin::CompleteDailyRoutesControllerTest < ActionDispatch::IntegrationTest
#   test 'should charge all users after completing service delivery' do
#     login_as_admin
#
#     # create data
#     populate_for_daily_routes
#     puts ServiceDelivery.last.inspect
#     puts @dailiy_route.inspect
#
#     # driver or admin hits endpoint
#     patch api_v1_admin_complete_daily_route_path(@daily_route),
#         headers: @admin_headers
#
#     # stripe picks all completed service deliveries
#     # stripe charges customer
#
#     # webhook:
#     #   all deliveries on route are marked complete
#     #   payment is created
#     #   delivery is marked paid
#   end
# end
