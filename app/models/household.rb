class Household < ActiveRecord::Base
  has_many :members
  has_many :transactions

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
