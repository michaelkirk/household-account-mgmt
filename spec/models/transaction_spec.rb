require 'spec_helper'

describe Transaction do
  before do
    @household = Household.create!
  end

  it "should not allow negative amount" do
    t = Transaction.new(:amount => -1.20)
    t.should have(1).error_on(:amount)
  end

  describe "::total_balance" do

    it "should accumulate balance of all transactions" do
      Transaction.total_balance.should == 0
      Transaction.create!(:household => @household, :amount => 2.01, :credit => true)
      Transaction.create!(:household => @household, :amount => 1.10, :credit => true)
      Transaction.total_balance.should == 3.11
    end

    it "should accumulate debits negatively" do
      Transaction.total_balance.should == 0
      Transaction.create!(:household => @household, :amount => 2.01, :credit => true)
      Transaction.create!(:household => @household, :amount => 1.10, :credit => false)
      Transaction.total_balance.should == 0.91
    end
  end

  describe "write-once transactions" do
    before do
      @credit = Transaction.create!(:household => @household, :amount => 2.01, :credit => true)
      @household2 = Household.create!
    end

    it "should set amount, household, and balance via mass assignment on creation" do
      t = Transaction.create!(:household => @household, :amount => 2.01, :credit => true)
      t.new_record?.should == false
      t.household.should == @household
      t.amount.should == 2.01
      t.credit.should == true
    end

    it "should not let you update the amount via mass assignment" do
      @credit.update_attributes({:amount => 3.01})
      # model attribute will appear updated, but not actually persisted to DB, hence the reload.
      # https://rails.lighthouseapp.com/projects/8994-ruby-on-rails/tickets/2132-confusing-behavior-with-attr_readonly#ticket-2132-14
      @credit.save!
      @credit.reload.amount.should == 2.01 
    end

    it "should not let you update the household via mass assignment" do
      @credit.update_attributes({:household => @household2})
      # model attribute will appear updated, but not actually persisted to DB, hence the reload.
      # https://rails.lighthouseapp.com/projects/8994-ruby-on-rails/tickets/2132-confusing-behavior-with-attr_readonly#ticket-2132-14
      @credit.save!
      @credit.reload.household.should == @household
    end

    it "should not let you update the credit attribute via mass assignment" do
      @credit.update_attributes({:credit => false})
      # model attribute will appear updated, but not actually persisted to DB, hence the reload.
      # https://rails.lighthouseapp.com/projects/8994-ruby-on-rails/tickets/2132-confusing-behavior-with-attr_readonly#ticket-2132-14
      @credit.save!
      @credit.reload.credit.should == true
    end
  end

end
