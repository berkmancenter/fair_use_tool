# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Cms::Authentication::Controller
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  helper_method :admin?
  filter_parameter_logging :password, :password_confirmation
  layout 'templates/default'
  
end