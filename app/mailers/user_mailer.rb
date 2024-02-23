class UserMailer < ApplicationMailer
  def user_notification(event)
    @event = event
    mail(to:@event.user.email, subject: "Recordatorio para el evento: #{@event.title}")
  end
end
