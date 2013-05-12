class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  # For now, until authentication is implemented,
  # current user is always first user from db
  def current_user
    @current_user ||= User.first
  end
end
