class RemoveFilemakerIds < ActiveRecord::Migration
  def up
    remove_column :households, :fm_id
    remove_column :members, :fm_id
  end

  def down
    add_column :households, :fm_id, :integer
    add_column :members, :fm_id, :integer
  end
end
