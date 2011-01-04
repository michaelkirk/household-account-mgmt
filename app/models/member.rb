class Member < ActiveRecord::Base
  belongs_to :household

  def housemate=(housemate)
    self.household= housemate.household
  end

  def housemate_id=(housemate_id)
    self.housemate=Member.find(housemate_id)
  end

  def housemate_id
    nil
  end

  def household=(new_household)
    if(new_household != household and household.members.count=1)
      old_balace= household.balance
      household.debit(old_balance)
      new_household.credit(old_balance)
    end
    
    self[:household]= new_household

  end

  def name
    "#{first_name} #{last_name}"
  end
end
