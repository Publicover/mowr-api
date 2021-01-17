# frozen_string_literal: true

class Api::V1::Admin::PaymentMethodsController < ApplicationController
  before_action :set_payment_method, except: %i[index create]

  def index
    @payment_methods = policy_scope([:api, :v1, PaymentMethod])
    authorize [:api, :v1, @payment_methods]
    serialized_response(@payment_methods)
  end

  def show
    serialized_response(@payment_method)
  end

  def create
    @payment_method = PaymentMethod.new(payment_method_params)
    authorize [:api, :v1, @payment_method]

    serialized_response(@payment_method) if @payment_method.save
  end

  def update
    @payment_method.update(payment_method_params)
    serialized_response(@payment_method)
  end

  def destroy
    @payment_method.destroy
    serialized_response(@payment_method)
  end

  private

    def set_payment_method
      @payment_method = PaymentMethod.find(params[:id])
      authorize [:api, :v1, @payment_method]
    end

    def payment_method_params
      params.require(:payment_method).permit(policy([:api, :v1, PaymentMethod]).permitted_attributes)
    end
end
