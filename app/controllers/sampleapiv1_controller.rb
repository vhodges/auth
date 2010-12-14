#
# This is just an example of the actions that need to be implemented for the API to function
# I may move some common code into a base controller, but will develop in this file first
#
# Version 1 API methods:
#
#  profile           - Return information about the current member
#  register_callback - register a notification/alert webhook for the current member
#  remove_callback   - un register the notification/alert webhook for the current member
#
# All actions render text and/or JSON removing the need for views
#
# When providing your implementation, create a new controller that implements these
# actions and update the routes in config/routes.rb to use your new controller.
#

class Sampleapiv1Controller < VersionOneApiController

  def register_callback
    render :text => "OK"
  end

  def remove_callback
    render :text => "OK"
  end

end
