class HouseholdMembershipAudit < ActiveRecord::Base
  belongs_to :household
  belongs_to :member

  validates_presence_of :household, :member, :event
  validates_inclusion_of :event, :in => ['left', 'joined']

end

# == Schema Information
#
# Table name: household_membership_audits
#
#  id           :integer(4)      not null, primary key
#  household_id :integer(4)
#  member_id    :integer(4)
#  event        :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

