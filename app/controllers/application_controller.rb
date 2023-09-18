class ApplicationController < ActionController::Base
  
  before_action :record_page_view
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def record_page_view
    # Add a condition to record only your canonical domain
    # and use a gem such as crawler_detect to skip bots.
    ActiveAnalytics.record_request(request)
  end
  
  protected
  
  def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

end
