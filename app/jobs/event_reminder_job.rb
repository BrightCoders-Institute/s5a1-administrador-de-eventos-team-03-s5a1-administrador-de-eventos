class EventReminderJob < ApplicationJob
  queue_as :default

  def perform(event_id, event_updated_at)
    # Do something later
    event = BrightEvent.find(event_id)
    return if event.updated_at.to_s != event_updated_at.to_s
    UserMailer.user_notification(event).deliver_now

  end
end
