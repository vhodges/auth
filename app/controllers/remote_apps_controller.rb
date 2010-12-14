class RemoteAppsController < ApplicationController

  before_filter :authenticate_user!
  layout 'admin'

  access_control do
    allow :admin
  end

  def index
    @remote_apps =  Rack::OAuth2::Server::Client.all
  end

  def show
    @remote_app = Rack::OAuth2::Server::Client.find(params[:id])
  end

  def new
    @remote_app = Rack::OAuth2::Server::Client.new
  end

  def create
    logger.info("Update: remote_app = #{@remote_app.inspect}.  Validate Params = #{validate_params(params)}")
    client = Rack::OAuth2::Server::Client.create(validate_params(params))
    flash[:notice] = "Successfully created client application record."
    redirect_to apps_url
  end

  def edit
    @remote_app = Rack::OAuth2::Server::Client.find(params[:id])
  end

  def update
    @remote_app = Rack::OAuth2::Server::Client.find(params[:id])
    logger.info("Update: remote_app = #{@remote_app.inspect}.  Validate Params = #{validate_params(params)}")
    begin
      @remote_app.update validate_params(params)
      logger.info("After Update: remote_app = #{@remote_app.inspect}")
    rescue Exception => e
      logger.info("Exception: #{e.message}")
    end
    flash[:notice] = "Successfully updated the client application record."
    redirect_to apps_url
  end

  def destroy
    Rack::OAuth2::Server::Client.delete(params[:id])
    flash[:notice] = "Successfully destroyed the client application record."
    redirect_to apps_url
  end

  def revoke
    @remote_app = Rack::OAuth2::Server::Client.find(params[:id])
    @remote_app.revoke!
    flash[:notice] = "Successfully revoked authorization of the client application record."
    redirect_to apps_url
  end

  protected
  # This method is a bit of a mis-nomer, but could do validations in the future
  # For now it just makes sure that ony certain params are extracted from the
  # incoming params for use in the model.
  def validate_params(params)
    p = { }
    p[:display_name] = params[:display_name]
    p[:link] = params[:link]
    p[:image_url] = params[:image_url]
    p[:redirect_uri] = params[:redirect_uri]
    return p
  end

end
