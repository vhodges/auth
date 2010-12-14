require 'omniauth/core'

module OmniAuth
  module Strategies
    class HostProviderExample
      include OmniAuth::Strategy

      # Initialize the Sample host authenticator Middleware
      #
      # @param [Rack Application] app Standard Rack middleware argument.
      # @option options [String, 'Host Authentication'] :title A title for the authentication form.
      def initialize(app, options = {}, &block)

        super(app, options[:name] || :host_provider_example, options.dup, &block)

        Rails.logger.info("initialize")

        # Other options might include host/port information for the host
      end

      protected

      def request_phase
        if env['REQUEST_METHOD'] == 'GET'
          get_credentials
        else
          perform
        end
      end

      def get_credentials
        Rails.logger.info("get_credentials")
        OmniAuth::Form.build("Please sign in") do
          text_field 'Account Number', 'username'
          password_field 'PAC', 'password'
        end.to_response
      end

      def perform
        begin
          account = request.POST['username']
          pac = request.POST['password']

          # A real implementation would query the host/core-banking system
          # to compare the credentials and supply the user profile data.
          #
          # If extra fields are needed (ie a branch number), it can be added
          # to the form about (in get_credentials) and used here.
          #
          # For now, all accounts 'work' and are called 'Box account_number'
          @user_info = { "account" => account, 'name' => "Bob #{account}"}

          @env['omniauth.auth'] = auth_hash
          #@env['REQUEST_METHOD'] = 'GET'
          @env['PATH_INFO'] = "#{OmniAuth.config.path_prefix}/#{name}/callback"

          call_app!
        rescue Exception => e
          Rails.logger.info("Exception => #{e.inspect}")
          fail!(:invalid_credentials, e)
        end
      end

      def callback_phase
        fail!(:invalid_request)
      end

      def auth_hash
        OmniAuth::Utils.deep_merge(super, {
                                     'uid' => @user_info["account"],
                                     'user_info' => @user_info
                                   })
      end

    end
  end
end

