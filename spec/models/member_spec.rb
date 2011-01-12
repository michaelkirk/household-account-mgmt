require 'spec_helper'

describe Member do

  def household
    @household ||= Household.create!
  end

  describe "#household" do

    it "should belong to the assigned household if one was specified on creation" do
      m= Member.create!(:household => household)
      m.household.should == household
      
      #reload household to verify relation persisted in DB
      db_household = Household.find(household.id)
      db_household.members.should include m
    end

    it "should have a new houshold assigned on creation if one wasn't specified" do
      m= Member.create!
      m.household.should_not be_nil
      m.household.members.should == [m]
    end

  end

end
