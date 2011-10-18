#
# Default callback saver.  Use this unless you have special needs
# for sending out account activity when it occurs.
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
