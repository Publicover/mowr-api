# frozen_string_literal: true

module PaymentMethodsMutation
  def create_payment_method_helper(user_id)
    <<~GQL
      mutation {
        createPaymentMethod(input:{params:{
          nickname: "New Test",
          stripePmId: "pm_card_visa",
          stripeUserId: "cus_Il0otsjoN4ck5r",
          stripeToken: "tok_visa",
          brand: "visa",
          last4: "4242",
          expMonth: "12",
          expYear: "2050",
          status: 0,
          userId: #{user_id}
        }}) {
            paymentMethod {
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
      }
    GQL
  end

  def update_payment_method_helper(id, name)
    <<~GQL
      mutation {
        updatePaymentMethod(input:{id:#{id}, params:{
          nickname: "#{name}",
        }}) {
            paymentMethod {
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
      }
    GQL
  end

  def destroy_payment_method_helper(id)
    <<~GQL
      mutation {
        destroyPaymentMethod(input:{id:#{id}}) {
            isDeleted
        }
      }
    GQL
  end
end
