#
# Default callback saver.  Use this unless you have special needs
# for sending out account activity when it occurs.
#

# This implementation just saves the callback url on the juno.members table
#
# TODO This class should support potential multiple callback urls for each member
# (one for each app the user is using if the app has a callback)
#
# Right now, it's only Cashbook, so it doesn't matter too much yet.
#
class DefaultCallbackSaver

  # The contract has these two entry points
  def self.save_callback(member, callback)
    member.callback_url = callback
    member.save!
  end

  def self.clear_callback(member)
    member.callback_url = nil
    member.save!
  end

end
