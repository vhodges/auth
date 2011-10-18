#
# Use this as a reference when implementing Juno for your own organization
#

# Figure out where 'this' file is in the filesystem
FI_CONFIG_PATH = File.expand_path(File.dirname(__FILE__))

#
# coreauth options - these should be all that need to be edited.
#
HOST_AUTH_OPTIONS = {
  # Filename (relative to config directory) of the file containing the html for the login page.
  'login_page' => File.join(FI_CONFIG_PATH, "login.html"),

  'error_pages' => {
    'invalid_credentials' => File.join(FI_CONFIG_PATH, "invalid_credentials.html"),
    'disclaimer_needed' => File.join(FI_CONFIG_PATH, "disclaimer_needed.html"),
    'pac_change_needed' => File.join(FI_CONFIG_PATH, "pac_change_needed.html"),
  }
}

# Our callback saver.
require 'default_callback_saver'

#
# The demo/reference implementation runs under both ruby and jruby/java
#
begin
  require 'java'
  AuthClient = Java::ComPennyminderJuno::MockAuthClient
rescue Exception => e
  # Probably not running under java/jruby, create a mock AuthClient using plain old Ruby.
  class AuthClient
    def initialize(map)
    end

    def authenticateMember(account, branch, pac)
      return { 'error' => "invalid_credentials"}  # For now, TODO Implement a better pure ruby mock auth client.
    end
  end
end

#
# Define a class called FIConfig - the rest of Juno expects this class to be present
#
# The methods form the contract that is expected by the rest of Juno, all are
# required.  The implementations can of course be whatever you need them to be.
class FinancialInstitutionConfig

  # Return a hash containing the list of options needed for the host auth client class (also
  # to be supplied by you).  Passed into coreauth (the omniauth core banking auth strategy)
  # strategy via Devise
  def self.host_options
    return HOST_AUTH_OPTIONS
  end

  # Return a class constant that will be instantiated in coreauth to communicate with
  # the core banking system
  def self.corebanking_auth_client
    return AuthClient
  end

  # Return a class constant that will be instantiated in the api to save callback urls
  def self.callback_saver
    return DefaultCallbackSaver
  end

  # Return the name of the organization (used in the UI for printing the copywrite notice)
  def self.organization_name
    return "Sample Financial Institution"
  end
end

