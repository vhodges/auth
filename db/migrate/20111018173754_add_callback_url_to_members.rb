class AddCallbackUrlToMembers < ActiveRecord::Migration
  def self.up
    add_column :members, :callback_url, :string
  end

  def self.down
    remove_column :members, :callback_url
  end
end
