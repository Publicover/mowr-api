# frozen_string_literal: true

class Api::V1::Admin::PaymentsController < ApplicationController
  before_action :set_payment, except: [:index, :create]

  def index
    @payments = policy_scope([:api, :v1, Payment])
    authorize [:api, :v1, @payments]
    serialized_response(@payments)
  end

  def show
    serialized_response(@payment)
  end

  def create
    @payment = Payment.new(payment_params)
    authorize [:api, :v1, @payment]

    serialized_response(@payment) if @payment.save
  end

  def update
    @payment.update(payment_params)
    serialized_response(@payment)
  end

  def destroy
    @payment.destroy
    serialized_response(@payment)
  end

  private

    def set_payment
      @payment = Payment.find(params[:id])
      authorize [:api, :v1, @payment]
    end

    def payment_params
      params.require(:payment).permit(policy([:api, :v1, Payment]).permitted_attributes)
    end
end
