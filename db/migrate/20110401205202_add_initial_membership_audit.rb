class AddInitialMembershipAudit < ActiveRecord::Migration
  def self.up
    Member.all.each do |member|
      HouseholdMembershipAudit.create!(:household => member.household, :member => member, :event => 'joined', :created_at => member.created_at)
    end
  end

  def self.down

  end
end
