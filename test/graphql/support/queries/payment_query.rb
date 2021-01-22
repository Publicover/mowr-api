# frozen_string_literal: true

module PaymentQuery
  def index_payments_helper
    <<~GQL
      query {
        indexPayments {
          id
          costInCents
          stripeChargeId
          userId
          stripeUserId
          paymentMethodId
          last4
          receiptUrl

          paymentMethod {
            id
            nickname
          }
        }
      }
    GQL
  end

  def show_payment_helper(id)
    <<~GQL
      query {
        showPayment(id:#{id}) {
          id
          costInCents
          stripeChargeId
          userId
          stripeUserId
          paymentMethodId
          last4
          receiptUrl

          paymentMethod {
            id
            nickname
          }
        }
      }
    GQL
  end
end
