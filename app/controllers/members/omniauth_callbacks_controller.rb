class Members::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  skip_before_filter :verify_authenticity_token

  def host_provider_example
    # You need to implement the method below in your model
    @member = Member.find_for_host_auth(env["omniauth.auth"])

    flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "host_provider_example"

    # TODO I am pretty sure this should just redirect back to the oath controller authorize action
    # (getting the authorization code out of the session)
    sign_in_and_redirect @member, :event => :authentication

  end

end
