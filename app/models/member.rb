class Member < ActiveRecord::Base
  belongs_to :household

  before_validation do |member|
    # a member must always belong to a household. 
    # If they aren't currently in a household, make a new one for them.
    member.build_household if member.household.nil?
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
