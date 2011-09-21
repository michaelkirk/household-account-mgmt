require 'spec_helper'

describe Household do


  it "should default to a $0.00 balance" do
    Household.create!.balance.should == 0
  end

  describe "#credit!" do
    before do
      @household = Household.create!
    end

    it "should add the amount of credit to balance" do
      balance = @household.balance
      @household.credit!(BigDecimal.new("5"))
      @household.balance.should == balance + 5
    end

    it "should not allow credits <= 0" do
      lambda { @household.credit!(BigDecimal.new("-5")) }.should raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe "#debit!" do
    before do
      @household = Household.create!
    end

    it "should subtract the amount of debit to balance" do
      balance = @household.balance
      @household.debit!(BigDecimal.new("5"))
      @household.balance.should == balance - 5
    end

    it "should not allow debits <= 0" do
      lambda { @household.debit!(BigDecimal.new("-5")) }.should raise_error(ActiveRecord::RecordInvalid)
    end
  end

  pending "should be impossible to change balance without creating a transaction"
    
end
