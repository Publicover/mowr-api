class ServiceRequestMailer < ApplicationMailer
  def service_request_confirmation(user)
    @email = user.email

    mail(to: @email, subject: 'We recieved your request for service')
  end
end
