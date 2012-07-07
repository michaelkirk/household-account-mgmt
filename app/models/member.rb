class Member < ActiveRecord::Base
  belongs_to :household
  has_many :household_membership_audits

  scope :with_households, :include => [{:household => :members}]

  # The last member can't leave a household which has a non-zero balance, ensuring all money is accessible.
  validate do
    if(not new_record? and household_id_changed?)
      if(household_was.members == [self] and household_was.balance != 0)
        errors.add(:household, "You must transfer the old household's balance before removing it's last member.")
      end
    end
  end

  validates_presence_of :first_name, :last_name

  # Can we do this with something like:
  # words.split.inject(self.arel_table) do |members, word| 
  #   members.or(match('UPPER(first_name) LIKE UPPER(?) OR UPPER(last_name) LIKE UPPER(?)' , "%#{word}%", "%#{word}%"))
  # end
  def self.find_by_keywords(words)
    return Member.with_households if(words.strip.empty?)

    words.split.inject(Set.new()) do |matching_members, word|
      #Get all members who's first or last name matches
      matching_members + Member.with_households.where('UPPER(first_name) LIKE UPPER(?) OR UPPER(last_name) LIKE UPPER(?)' , "%#{word}%", "%#{word}%")
    end
  end

  def household_was
    if( household_id_was )
      Household.find(household_id_was)
    else
      nil
    end
  end

  before_validation do |member|
    # a member must always belong to a household.
    # If they aren't currently in a household, make a new one for them.
    member.build_household if member.household.nil?
  end

  # I would prefer a more general purpose auditing tool, but neither acts_as_audited nor vestal_versions
  # makes it easy to find both the addition of a member to a household and the removal.
  after_create do |member|
    HouseholdMembershipAudit.create!(:event => 'joined', :household_id => member.household_id, :member_id => member.id)
  end

  before_save do |member|
    # new record handled differently, in after_create,
    # because the member doesn't have an id before_create.
    # we can't generalize to "after_save" because the "member.household_was" is reset
    unless member.new_record?
      if member.household_id_changed?
        HouseholdMembershipAudit.create!(:event => 'joined', :household_id => member.household_id, :member_id => member.id)

        unless member.household_id_was.nil? #unless they weren't in a household before
          HouseholdMembershipAudit.create!(:event => 'left', :household_id => member.household_id_was, :member_id => member.id)
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

  #csv output
  comma do
    id
    last_name
    first_name
    household_id
    created_at
    updated_at
    phone1
    phone2
    address1
    address2
    city
    state
    zip
    notes
    active
    email
  end
end

# == Schema Information
#
# Table name: members
#
#  id           :integer(4)      not null, primary key
#  last_name    :string(255)
#  first_name   :string(255)
#  household_id :integer(4)
#  created_at   :datetime
#  updated_at   :datetime
#  phone1       :string(255)
#  phone2       :string(255)
#  address1     :string(255)
#  address2     :string(255)
#  city         :string(255)
#  state        :string(255)
#  zip          :string(255)
#  notes        :text
#  active       :boolean(1)      default(TRUE)
#  email        :string(255)
#  fm_id        :integer(4)
#

