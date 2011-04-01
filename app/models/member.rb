class Member < ActiveRecord::Base
  belongs_to :household
  has_many :household_membership_audits

  before_validation do |member|
    # a member must always belong to a household. 
    # If they aren't currently in a household, make a new one for them.
    member.build_household if member.household.nil?
  end

  # I would prefer a more general purpose auditing tool, but neither acts_as_audited nor vestal_versions
  # makes it easy to find both the addition of a member to a household and the removal.
  after_create do |member|
    HouseholdMembershipAudit.create!(:event => :joined, :household_id => member.household_id, :member_id => member.id)
  end

  before_save do |member|
    # new record handled differently, in after_create, 
    # because the member doesn't have an id before_create.
    # we can't generalize to "after_save" because the "member.household_was" is reset
    unless member.new_record? 
      if member.household_id_changed?
        HouseholdMembershipAudit.create!(:event => :joined, :household_id => member.household_id, :member_id => member.id)

        unless member.household_id_was.nil? #unless they weren't in a household before
          HouseholdMembershipAudit.create!(:event => :left, :household_id => member.household_id_was, :member_id => member.id)
        end
      end
    end
  end

  def to_s
    if name != ''
      name
    elsif email.to_s != ''
      email.to_s
    else
      '(unknown member)'
    end
  end

  def name
    "#{first_name} #{last_name}".strip
  end
end
