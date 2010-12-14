class AddUidToMembers < ActiveRecord::Migration
  def self.up
    add_column :members, :uid, :string
  end

  def self.down
    remove_column :members, :uid
  end
end
