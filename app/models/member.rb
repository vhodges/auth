class Member < ActiveRecord::Base

  devise :omniauthable

  def self.find_for_host_auth(access_token)
    member = Member.find_by_uid(access_token["uid"])
    unless member
      member = Member.create!(:uid => access_token["uid"])
    end
    member
  end

end
