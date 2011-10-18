class UpdateMemberIndexes < ActiveRecord::Migration
  def self.up
    add_index :members, :uid,                :unique => true
    remove_index :members, :email
  end

  def self.down
    remove_index :members, :uid
    add_index :members, :email,                :unique => true
  end
end
