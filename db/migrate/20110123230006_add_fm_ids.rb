class AddFmIds < ActiveRecord::Migration
  def self.up
    add_column :members, :fm_id, :integer
    add_column :households, :fm_id, :integer
  end

  def self.down
    remove_column :members, :fm_id
    remove_column :households, :fm_id
  end
end
