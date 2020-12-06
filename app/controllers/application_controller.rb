# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  include Pundit

  before_action :authorize_request
  attr_reader :current_user

  rescue_from Pundit::NotAuthorizedError do
    json_response({ message: Message.unauthorized })
  end

  private

    def authorize_request
      @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
    end

    def check_user_onboarding
      raise AuthenticationError unless current_user.onboarding_complete
    end
end
