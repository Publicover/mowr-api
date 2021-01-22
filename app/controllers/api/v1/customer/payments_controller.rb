# frozen_string_literal: true

class Api::V1::Customer::PaymentsController < ApplicationController
  def index
    @payments = policy_scope([:api, :v1, Payment])
    authorize [:api, :v1, @payments]

    serialized_response(@payments)
  end

  def show
    @payment = Payment.find(params[:id])
    authorize [:api, :v1, @payment]

    serialized_response(@payment)
  end
end
