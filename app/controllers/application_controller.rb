class ApplicationController < ActionController::Base
  # Adds a few additional behaviors into the application controller 
   include Blacklight::Controller
  # Please be sure to impelement current_user and user_session. Blacklight depends on 
  # these methods in order to perform user specific actions. 

  layout 'blacklight'

  protect_from_forgery

   before_filter :store_location, :authenticate_user!

   def store_location
     session[:return_to] = request.fullpath if (request.get? &&
         controller_name != "user_sessions" &&
         controller_name != "sessions" &&
         controller_name != "registrations" &&
         request.fullpath.match("users/password/") == nil &&
         request.fullpath.match("users/auth/cas/") == nil)
   end

   def after_sign_in_path_for(resource)
     session[:return_to] || "/"
   end


end
