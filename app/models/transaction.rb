class Transaction < ActiveRecord::Base
  belongs_to :household

  validates_inclusion_of :credit, :in => [true, false]
  validates_presence_of :household_id
  validates_presence_of :amount
  validates_numericality_of :amount

  scope :for_household, (lambda do |h| {:conditions => {:household_id => h}} end)
 
  after_create do |t|
    if(t.credit?)
      t.household.update_attribute(:balance, t.household.balance + t.amount)
    else
      t.household.update_attribute(:balance, t.household.balance - t.amount)
    end
    t.save!
  end

end
