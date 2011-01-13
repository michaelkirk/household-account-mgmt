class Member < ActiveRecord::Base
  belongs_to :household

  before_validation do |member|
    member.build_household if member.household.nil?
  end

  def to_s
    name
  end

  def name
    "#{first_name} #{last_name}"
  end
end
