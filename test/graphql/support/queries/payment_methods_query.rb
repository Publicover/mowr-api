# frozen_string_literal: true

module PaymentMethodsQuery
  def index_payment_methods_helper
    <<~GQL
      query {
        indexPaymentMethods {
          id
          nickname
          stripePmId
          stripeUserId
          stripeToken
          brand
          last4
          expMonth
          expYear
          status
          userId

          user {
            id
            fName
            lName
            email
            phone
            role
          }
        }
      }
    GQL
  end

  def show_payment_method_helper(id)
    <<~GQL
      query {
        showPaymentMethod(id:#{id}) {
          id
          nickname
          stripePmId
          stripeUserId
          stripeToken
          brand
          last4
          expMonth
          expYear
          status
          userId

          user {
            id
            fName
            lName
            email
            phone
            role
          }
        }
      }
    GQL
  end
end
