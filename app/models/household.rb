class Household < ActiveRecord::Base
  has_many :members
  has_many :transactions
  has_many :household_membership_audits

  #BUG this only matches if the submitted keywords are matched to a single user.
  # if I had a household with members "Alonzo Church" and "Edsger Dijktstra" I couldn't
  # search for Alonzo Edsger. I _think_ I should be able to.
  # perhaps I'm misunderstanding the type algebra.
  scope :find_by_keywords, lambda {|query|
    query.split.inject(find_by_member_name("")) {|accumulated_scope, word|
      accumulated_scope.find_by_member_name(word)}}
  scope :find_by_member_name, lambda { |name| 
    {:joins => :members, 
     :conditions => "UPPER(members.first_name) LIKE UPPER('%#{name}%') OR UPPER(members.last_name) LIKE UPPER('%#{name}%')"}
    #TODO protect from injection.
  }

  # All households with no members
  scope :empty, joins('left outer join members on members.household_id = households.id').select('households.*').where('members.id is null')

  def to_s
    if members.empty?
      "empty household"
    else
      members.inject { |a,b| "#{a}, #{b}"}
    end
  end
  
  def do_credit (amount)
    Transaction.create!(
      :credit => true, :amount => amount, :household_id => self.id)
    self.balance = self.balance + amount
    self.save
  end
  
  def do_debit (amount)
    Transaction.create!(
      :credit => false, :amount => amount, :household_id => self.id)
    self.balance = self.balance - amount
    self.save
  end

end
