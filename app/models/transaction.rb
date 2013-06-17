class Transaction < ActiveRecord::Base
  belongs_to :household

  validates_inclusion_of :credit, :in => [true, false], :message => "must be an investment (credit) or purchase (debit)"
  validates_presence_of :household_id
  validates_presence_of :amount
  validates_numericality_of :amount, :greater_than => 0

  scope :for_household, lambda { |h| where(:household_id => h).order("id DESC") }
  scope :investments, :conditions => { :credit => true }
  scope :purchases, :conditions => { :credit => false }
  scope :this_week, :conditions => ['created_at > ?', 7.days.ago]

  # attr_readonly allows you to change attr values of the model, but these changes won't be saved to the DB
  # https://rails.lighthouseapp.com/projects/8994-ruby-on-rails/tickets/2132-confusing-behavior-with-attr_readonly#ticket-2132-14
  attr_readonly :amount, :credit, :household_id

  after_create do |t|
    apply_transaction
    #todo do we need this 
    t.save!
  end
  
  after_save do |t|
    void_transaction if t.void? && !t.void_was
    apply_transaction if !t.void? && t.void_was
  end

  def void_transaction
    if(self.credit?)
      self.household.update_attribute(:balance, self.household.balance - self.amount)
    else
      self.household.update_attribute(:balance, self.household.balance + self.amount)
    end
  end

  def apply_transaction
    if(self.credit?)
      self.household.update_attribute(:balance, self.household.balance + self.amount)
    else
      self.household.update_attribute(:balance, self.household.balance - self.amount)
    end
  end

  def self.total_balance
    investments.sum(:amount) - purchases.sum(:amount)
  end

  def self.amount_purchased_this_week
    purchases.this_week.sum(:amount)
  end

  comma do
    id
    amount
    credit
    void
    message
    household_id
    created_at
    updated_at
  end

end

# == Schema Information
#
# Table name: transactions
#
#  id           :integer(4)      not null, primary key
#  amount       :decimal(8, 2)   not null
#  credit       :boolean(1)      not null
#  message      :string(255)
#  household_id :integer(4)      not null
#  created_at   :datetime
#  updated_at   :datetime
#

