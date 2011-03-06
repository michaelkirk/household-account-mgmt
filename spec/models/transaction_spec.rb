require 'spec_helper'

describe Transaction do

  pending "must have an amount"
  pending "must have a household"
  pending "must be either credit or debit"
  pending "should not be able to edit household"
  pending "should not be able to edit amount"
  pending "should not be able to edit credit?"

  it "should not allow negative amount" do
    t = Transaction.new(:amount => -1.20)
    t.should have(1).error_on(:amount)
  end

  describe "::total_balance" do
    before do
      @household = Household.create!
    end

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

end
