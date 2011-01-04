class CreateMembers < ActiveRecord::Migration
  def self.up
    create_table :members do |t|
      t.string :last_name
      t.string :first_name
      t.integer :household_id

      t.timestamps
    end
  end

  def self.down
    drop_table :members
  end
end
