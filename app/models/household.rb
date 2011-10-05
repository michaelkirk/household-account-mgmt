class Household < ActiveRecord::Base
  has_many :members
  has_many :transactions
  has_many :household_membership_audits

  #OPTIMIZE this horse shit.
  def self.find_by_keywords(words)
    return self.all if(words.strip.empty?)
    
    words.split.inject([]) do |members, word|
      #Get all members who's first or last name matches
      members | Member.where(:first_name => word) | Member.where(:last_name => word)
    end.map do |member|
      #Get their households
      member.household
    end.uniq #remove dupes.
  end

  # All households with no members
  scope :empty, joins('left outer join members on members.household_id = households.id').select('households.*').where('members.id is null')

  def to_s
    if members.empty?
      "empty household"
    else
      members.inject { |a,b| "#{a}, #{b}"}
    end
  end
  
  def credit! (amount)
    Transaction.create!(
      :credit => true, :amount => amount, :household_id => self.id)
    self.update_attribute(:balance, self.balance + amount)
  end
  
  def debit! (amount)
    Transaction.create!(
      :credit => false, :amount => amount, :household_id => self.id)
    self.update_attribute(:balance, self.balance - amount)
  end

end
