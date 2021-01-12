# frozen_string_literal: true

module Mutations
  module Destroy
    class DestroyService < Mutations::BaseMutation
      argument :id, ID, required: true

      field :is_deleted, String, null: true

      def ready?(**_args)
        error_unless_admin
      end

      def resolve(id:)
        check_logged_in_user

        service = Service.find(id)

        service.destroy

        { is_deleted: Message.is_deleted(service).to_s }
      end
    end
  end
end
