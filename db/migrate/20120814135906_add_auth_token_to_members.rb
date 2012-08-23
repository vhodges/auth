class AddAuthTokenToMembers < ActiveRecord::Migration
  def self.up
    add_column :members, :authentication_token, :string
  end

  def self.down
    remove_column :members, :authentication_token
  end
end
