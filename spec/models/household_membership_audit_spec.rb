require 'spec_helper'

describe HouseholdMembershipAudit do

  before do
    @original_household = Household.create
    @new_houshold = Household.create
    @member = Factory(:member, :household => @original_household)
  end

  it "should create an initial 'join' audit for new household membership " do
    @member.household_membership_audits.count.should == 1
    @member.household_membership_audits[0].household.should == @original_household
  end

  describe "it should audit household moves" do

    before do
      @member.household = @new_household
      @member.save!
    end

    it "should create 2 new audits" do
      @member.household_membership_audits.count.should == 3
    end


    it "should create a 'join' audit when moving to a new household" do
      @member.household_membership_audits[1].household == @original_household
      @member.household_membership_audits[1].event == 'left'
    end

    it "should create a 'leave' audit when moving to a new household" do
      @member.household_membership_audits[2].household == @new_household
      @member.household_membership_audits[2].event == 'joined'
    end
  end

end
