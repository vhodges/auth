#
# Version 1 API methods:
#
#  profile           - Return information about the current member
#  register_callback - register a notification/alert webhook for the current member
#  remove_callback   - un register the notification/alert webhook for the current member
#
# All actions render text and/or JSON removing the need for views
#
#
class VersionOneApiController < ApplicationController

  before_filter :log_in_if_needed
  oauth_required
  
  def profile
    data = {
      "extra" => {
        "emails" => FinancialInstitutionConfig.email_alert_contacts(@current_member),
        "phones" => FinancialInstitutionConfig.phone_alert_contacts(@current_member),
        "token"  => @current_member.authentication_token
      },
      "uid" => @current_member.uid,
    }

    render :text => data.to_json
  end

  def register_callback
    # TODO Should have validation on the callback url of some kind.
    FinancialInstitutionConfig.callback_saver().save_callback(@current_member, params[:callback])
    render :text => "OK"
  end

  def remove_callback
    FinancialInstitutionConfig.callback_saver().clear_callback(@current_member)
    render :text => "OK"
  end

  protected

  def log_in_if_needed
    set_current_member
    unless @current_member
      redirect_to member_omniauth_authorize_path(:coreauth)
    end
  end

  def set_current_member
    Rails.logger.info("Authenticated?: #{oauth.authenticated?}, oauth.identity = #{env['oauth.identity']} ")
    Rails.logger.info("oauth: #{oauth.inspect}")
    @current_member = Member.find(env['oauth.identity']) if oauth.authenticated?
  end

end
