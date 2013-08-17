class ApplicationController < ActionController::Base
  protect_from_forgery

  @app_message = Message.new
  
end
