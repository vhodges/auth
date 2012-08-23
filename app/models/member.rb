class Member < ActiveRecord::Base

  devise :omniauthable 
  devise :token_authenticatable, :token_authentication_key => "apiauth"
  
  before_save :ensure_authentication_token                                                                              
  
  def self.find_for_host_auth(access_token)
    member = Member.find_by_uid(access_token["uid"])
    unless member
      Rails.logger.info("access_token = #{access_token.inspect}")

      member = Member.create!(:uid => access_token["uid"],
                              :name => access_token["user_info"]['name'],
                              :account => access_token["user_info"]['account'],
                              :branch => access_token["user_info"]['branch'])
    end
    member
  end


end
