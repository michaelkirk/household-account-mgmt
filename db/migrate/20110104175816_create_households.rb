class CreateHouseholds < ActiveRecord::Migration
  def self.up
    create_table :households do |t|
      t.string :name
      t.decimal :balance, :precision => 8, :scale => 2, :default => 0.0

      t.timestamps
    end
  end

  def self.down
    drop_table :households
  end
end
