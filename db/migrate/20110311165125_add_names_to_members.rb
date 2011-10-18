class AddNamesToMembers < ActiveRecord::Migration
  def self.up
    add_column :members, :first_name, :string
    add_column :members, :last_name, :string
  end

  def self.down
    remove_column :members, :last_name
    remove_column :members, :first_name
  end
end
