# frozen_string_literal: true

module PaymentsMutation
  def create_payment_helper(user_id, payment_method_id)
    <<~GQL
      mutation {
        createPayment(input:{params:{
          costInCents: 500,
          stripeChargeId:"fake_charge_again",
          userId:#{user_id},
          stripeUserId:"cus_asdf",
          paymentMethodId:#{payment_method_id},
          last4:"4242",
          receiptUrl:"www.paid.com"
        }}) {
          payment {
            id
            stripeChargeId
        	}
        }
      }
    GQL
  end

  def update_payment_helper(id)
    <<~GQL
      mutation {
        updatePayment(input:{id:#{id}, params:{
          costInCents:555500
        }}) {
          payment {
            id
            stripeChargeId
            costInCents
        	}
        }
      }
    GQL
  end

  def destroy_payment_helper(id)
    <<~GQL
      mutation {
        destroyPayment(input:{id:#{id}}) {
          isDeleted
        }
      }
    GQL
  end
end
