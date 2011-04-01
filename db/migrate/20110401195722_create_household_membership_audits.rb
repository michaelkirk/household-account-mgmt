class CreateHouseholdMembershipAudits < ActiveRecord::Migration
  def self.up
    create_table :household_membership_audits do |t|
      t.belongs_to :household
      t.belongs_to :member
      t.string :event

      t.timestamps
    end
  end

  def self.down
    drop_table :household_membership_audits
  end
end
