class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  # Why do we have to specify this here AND in initializers/time_zone.rb?
  Time.zone="Pacific Time (US & Canada)"
end
