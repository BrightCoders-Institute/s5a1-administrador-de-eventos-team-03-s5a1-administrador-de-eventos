class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    user_bright_events_path
  end
end
