require 'spec_helper'

describe MembersController do
  fixtures :households

  describe "#create " do
    it "should succeed" do
      Member.any_instance.stubs(:valid?).returns(true)
      post 'create'
      response.should redirect_to(assigns[:member])
    end

    it "should assign a new household if none was specified" do
      post 'create', {:member => {:household_id => nil}}
      #the new member should be the only one in their new household
      assigns[:member].household.members.should == [assigns[:member]]
    end

    it "should assign the existing household when specified" do
      Member.any_instance.stubs(:valid?).returns(true)
      post 'create', {:member => {:household_id => Household.first.id}}
      assigns[:member].household.should == Household.first
    end
  end

  describe "#update " do
    it "should move the member to the specified household" do
      Member.any_instance.stubs(:valid?).returns(true)
      post 'create', {:member => {:household_id => Household.first.id}}

      #the new member should be the only one in their new household
      assigns[:member].household.should == Household.first
    end

    it "should put the member in a new household if the specified household id is empty" do
      Member.any_instance.stubs(:valid?).returns(true)
      post 'create', {:member => {:household_id => nil}}

      #the new member should be the only one in their new household
      assigns[:member].household.members.should == [assigns[:member]]
    end
  end
end
