# frozen_string_literal: true

module Mutations
  module Destroy
    class DestroyBaseLocation < Mutations::BaseMutation
      argument :id, ID, required: true

      field :is_deleted, String, null: true

      def ready?(**args)
        error_unless_admin
      end

      def resolve(id:)
        check_logged_in_user

        base_location = BaseLocation.find(id)

        base_location.destroy

        { is_deleted: Message.is_deleted(base_location).to_s }
      end
    end
  end
end
