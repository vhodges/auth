require 'omniauth/core'

require 'digest/sha1'

class AuthenticationErrorMessage

  def initialize(error)
    @error_message = error
  end

  def get_binding
    binding
  end
end

module OmniAuth
  module Strategies
    class Coreauth
      include OmniAuth::Strategy

      def get_authentication_client
        @client
      end

      # Initialize the host authenticator Middleware
      #
      # @param [Rack Application] app Standard Rack middleware argument.
      def initialize(app, options = {}, &block)

        super(app, options[:name] || :coreauth, options.dup, &block)

        Rails.logger.info("initializing ")

        @host_options = options[:host_options]
        @login_page = @host_options['login_page'] # Filename of the file containing the html for the login page.
        @error_pages = @host_options['error_pages']

        # Connect to the host system
        @client = FinancialInstitutionConfig.corebanking_auth_client()
      end

      protected

      def request_phase
        if env['REQUEST_METHOD'] == 'GET'
          get_credentials
        else
          perform
        end
      end

      # Display the login form.
      def get_credentials
        Rails.logger.info("get_credentials")
        if request.params['message']
          if request.params['message'] == ""
            error = "Unknown Error"
          else
            begin
              error =  File.read(@error_pages[request.params['message']])
            rescue Exception => e
              error = "Error: " + request.params['message']
            end
          end
        end
        aem = AuthenticationErrorMessage.new(error)
        html = ERB.new(File.read(@login_page))  # Read every time - allows for changes while running
        res = html.result(aem.get_binding)
        Rack::Response.new(res).finish
      end

      #
      # use the corebanking auth client to authenticate the user credentials
      #
      def perform
        begin

          # Values from the form.
          account = request.POST['account']
          pac = request.POST['password']
          branch = request.POST['branch']  # Can be a hidden field if always same branch

          # Hashmap/Hash
          auth_details = get_authentication_client().authenticateMember(account, branch, pac)

          raise Exception.new(auth_details["error"]) if auth_details["error"]

          @user_info = auth_details["user_info"]

          @env['omniauth.auth'] = auth_hash
          @env['PATH_INFO'] = "#{OmniAuth.config.path_prefix}/#{name}/callback"

          call_app!
        rescue Exception => e
          #Rails.logger.info("Exception => #{e.inspect}")
          Rails.logger.info("Message: #{e.message}")
          #Rails.logger.info("Backtrace: #{e.backtrace}")
          fail!(e.message, e)
        end
      end

      def callback_phase
        fail!(:invalid_request)
      end

      def uid
        Digest::SHA1.hexdigest("#{@user_info["branch"]}-#{@user_info["account"]}")
      end

      def auth_hash
        OmniAuth::Utils.deep_merge(super, {
                                     'uid' => uid,
                                     'user_info' => @user_info
                                   })
      end

    end
  end
end

