#
# Base class for API implementations.  Have yours extend this class.
#
class VersionOneApiController < ApplicationController

  before_filter :log_in_if_needed

  #before_filter :set_current_user
  #oauth_required

  # TODO Implement this method (it should be the same for all implementations
  # (as the omniauth provider imple will provide the common info for the profile data)
  def profile
    render :text => "Profile data goes here."
  end

  protected

  def log_in_if_needed
    unless current_member
      redirect_to member_omniauth_authorize_path(:host_provider_example)
    end
  end

  def set_current_user
    @current_member = Member.find(oauth.identity) if oauth.authenticated?
  end

end
