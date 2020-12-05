class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  before_action :authorize_request
  attr_reader :current_user

  private

    def authorize_request
      @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
    end

    def check_user_onboarding
      raise AuthenticationError unless current_user.onboarding_complete
    end
end
