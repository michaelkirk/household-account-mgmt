class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :set_revision_url

  # Why do we have to specify this here AND in initializers/time_zone.rb?
  Time.zone="Pacific Time (US & Canada)"

  def set_revision_url
    @revision_url = 'https://github.com/michaelkirk/household-account-mgmt/'
    @revision += "tree/#{ENV['commit_hash']}" unless ENV['commit_hash'].nil?
  end
end
