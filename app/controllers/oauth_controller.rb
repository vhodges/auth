class OauthController < ApplicationController
  def authorize
    if current_member
      render :action=>"authorize"
    else
      # TODO Probably need to put the authorization into the session before redirecting
      redirect_to member_omniauth_authorize_path(:host_provider_example, :authorization=>oauth.authorization)
    end
  end

  def grant
    head oauth.grant!(current_member.id)
  end

  def deny
    head oauth.deny!
  end
end
