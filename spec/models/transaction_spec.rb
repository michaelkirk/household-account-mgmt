require 'spec_helper'

describe Transaction do

  it "should not allow negative amount" do
    t = Transcation.new(:amount => -1.20)
    t.should have_error(:on => :amount)
  end

  describe "::total_balance" do
    it "should accumulate balance of all transactions" do
      Transaction.total_balance.should = 0
      Transaction.create!(:amount => 2.01, :credit => true)
      Transaction.create!(:amount => 1.10, :credit => true)
      Transaction.total_balance.should == 3.11
    end

    it "should accumulate debits negatively" do
      Transaction.total_balance.should = 0
      Transaction.create!(:amount => 2.01, :credit => true)
      Transaction.create!(:amount => 1.10, :credit => false)
      Transaction.total_balance.should == 0.91
    end
  end

end
