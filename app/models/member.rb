class Member < ActiveRecord::Base
  belongs_to :household

  before_validation do |member|
    member.build_household if member.household.nil?
  end

  def housemate=(housemate)
    self.household= housemate.household
  end

  def housemate_id=(housemate_id)
    #create a new household if an existing one wasn't selected
    if(housemate_id == "")
      self.household = Household.create!
    else
      self.housemate=Member.find(housemate_id)
    end
  end

  def housemate_id
    nil
  end
  
  def household=(new_household)
    unless(household.nil?)
      raise Exception.new("moving household's is not yet implemented")
    end
    self[:household_id]=new_household.id
  end

  def name
    "#{first_name} #{last_name}"
  end
end
