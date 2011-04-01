class HouseholdMembershipAudit < ActiveRecord::Base
  belongs_to :household
  belongs_to :member
end
