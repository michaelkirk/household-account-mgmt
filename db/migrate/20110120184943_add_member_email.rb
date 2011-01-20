class AddMemberEmail < ActiveRecord::Migration
  def self.up
    add_column(:members, :email, :string)
  end

  def self.down
    remove_column(:members, :email)
  end
end
