# frozen_string_literal: true

module Response
  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def serialized_response(object, klass)
    klass = Object.const_get("#{klass}Serializer")
    render status: :ok, json: klass.new(object).serialized_json
  end
end
