class ModifyMembers < ActiveRecord::Migration
  def self.up
    add_column :members, :branch, :string
    add_column :members, :account, :string
    add_column :members, :name, :string

    remove_column :members, :first_name
    remove_column :members, :last_name
  end

  def self.down
    remove_column :members, :name
    remove_column :members, :account
    remove_column :members, :branch

    add_column :members, :first_name, :string
    add_column :members, :last_name, :string
  end
end
