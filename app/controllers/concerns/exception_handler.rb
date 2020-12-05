module ExceptionHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two

    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message })
    end
  end

  private

    # rubocop:disable Naming/MethodParameterName
    def four_twenty_two(e)
      json_response({ message: e.message }, :unprocessable_entity)
    end
    # rubocop:enable Naming/MethodParameterName

    # rubocop:disable Naming/MethodParameterName
    def unauthorized_request(e)
      json_response({ message: e.message }, :unauthorized)
    end
  # rubocop:enable Naming/MethodParameterName
end
