class Members::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  skip_before_filter :verify_authenticity_token

  def coreauth

    Rails.logger.info("Members callback for coreauth")

    # You need to implement the method below in your model
    @member = Member.find_for_host_auth(env["omniauth.auth"])

    Rails.logger.info("@member = #{@member.inspect}")

    flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "coreauth"

    # TODO I am pretty sure this should just redirect back to the oath controller authorize action
    # (getting the authorization code out of the session)
    sign_in @member, :event => :authentication
    redirect_to session["return_to"]
    #sign_in_and_redirect @member, :event => :authentication
  end

  def failure
    Rails.logger.info("Failure! message = '#{env['omniauth.error.type']}'")
    redirect_to member_omniauth_authorize_path(:coreauth, :message => env['omniauth.error.type'])
  end
end
