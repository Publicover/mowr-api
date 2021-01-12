# frozen_string_literal: true

module Mutations
  module Destroy
    class DestroyDailyRoute < Mutations::BaseMutation
      argument :id, ID, required: true

      field :is_deleted, String, null: true

      def ready?(**args)
        error_unless_admin
      end

      def resolve(id:)
        check_logged_in_user

        daily_route = DailyRoute.find(id)
        daily_route.destroy

        { is_deleted: Message.is_deleted(daily_route).to_s }
      end
    end
  end
end
