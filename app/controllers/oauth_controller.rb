class OauthController < ApplicationController
  def authorize
    if current_member
      # Already an authorization for this user and client app?
      if Rack::OAuth2::Server.token_for(current_member.id, oauth.client.id)
        redirect_to :action => 'grant', :authorization => oauth.authorization
      else
        render :action=>"authorize"
      end
    else
      session["return_to"] = request.fullpath
      Rails.logger.info("fullpath = #{request.fullpath}")
      redirect_to member_omniauth_authorize_path(:coreauth, :authorization=>oauth.authorization)
    end
  end

  def grant
    head oauth.grant!(current_member.id)
  end

  def deny
    head oauth.deny!
  end
end
