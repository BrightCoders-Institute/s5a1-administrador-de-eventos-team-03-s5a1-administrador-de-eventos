module BrightEventsHelper
  def filters_action
    if action_name != 'index'
      user_bright_events_path
    else
      bright_events_path
    end
  end
end
