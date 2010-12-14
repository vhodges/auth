source 'http://rubygems.org'

gem 'rails', '3.0.0'          # Rails
gem 'mysql2'                  # DB Driver
gem 'unicorn'                 # Use unicorn as the web server


gem 'capistrano'              # Deploy with Capistrano
gem 'capistrano-ext'

#                             # Login & Authorization
gem 'devise', :git => "git://github.com/plataformatec/devise.git"
gem 'acl9'
gem 'rack-oauth2-server'      # For authorizing remote client apps.
gem "oa-oauth", :require => "omniauth/oauth"

gem "formtastic"              # Forms
gem "inherited_resources"     # Controller

gem "paperclip"               # Active Record plugins
gem "transitions", :require => ["transitions", "active_record/transitions"]

gem 'awesome_print'           # Utils

# gem 'ruby-debug'            # To use debugger

group :development, :test do
  gem 'web-app-theme', '>= 0.6.2'
end

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end
