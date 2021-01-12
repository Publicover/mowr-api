# frozen_string_literal: true

module Mutations
  module Destroy
    class DestroySnowAccumulation < Mutations::BaseMutation
      argument :id, ID, required: true

      field :is_deleted, String, null: true

      def ready?(**_args)
        error_unless_admin
      end

      def resolve(id:)
        check_logged_in_user

        snow_accumulation = SnowAccumulation.find(id)

        snow_accumulation.destroy

        { is_deleted: Message.is_deleted(snow_accumulation).to_s }
      end
    end
  end
end
