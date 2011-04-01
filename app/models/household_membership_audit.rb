class HouseholdMembershipAudit < ActiveRecord::Base
  belongs_to :household
  belongs_to :member

  validates_presence_of :household, :member, :event
  validates_inclusion_of :event, :in => ['left', 'joined']

end
