source 'http://rubygems.org'

gem 'bundler'

gem 'rails', '3.0.10'          # Rails

platforms :ruby do
  gem 'mysql2', '< 0.3'                  # DB Driver

  gem 'unicorn'                 # Use unicorn as the web server

  gem 'capistrano'              # Deploy with Capistrano
  gem 'capistrano-ext'

  gem 'ruby-debug19'            # To use debugger
  gem 'bson_ext'
end

platforms :jruby do
  gem 'activerecord-jdbcmysql-adapter'
  gem 'jruby-openssl'
  gem 'trinidad'
  gem 'trinidad_lifecycle_extension'
  gem 'trinidad_daemon_extension'
  gem 'puma'
end

#                             # Login & Authorization
gem 'devise'#, :git => "git://github.com/plataformatec/devise.git"
gem 'acl9'

gem 'bson'
gem 'mongodb'
gem 'rack-oauth2-server'      # For authorizing remote client apps.
gem "oa-oauth",  '0.3.0',:require => "omniauth/oauth"

gem "formtastic"              # Forms
gem "inherited_resources"     # Controller

gem "paperclip"               # Active Record plugins
gem "transitions", :require => ["transitions", "active_record/transitions"]

gem 'awesome_print'           # Utils


#group :development, :test do
#  gem 'web-app-theme', '>= 0.6.2'
#end

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end
