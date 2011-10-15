require 'spec_helper'

describe Member do

  def household
    @household ||= Household.create!
  end

  describe "#household" do

    it "should belong to the assigned household if one was specified on creation" do
      m = Factory.build(:member)
      m.household = household
      m.save!
      m.household.should == household
      
      #reload household to verify relation persisted in DB
      db_household = Household.find(household.id)
      db_household.members.should include m
    end

    it "should have a new household assigned on creation if one wasn't specified" do
      m = Factory.build(:member)
      m.save!
      m.household.should_not be_nil
      m.household.members.should == [m]
    end

    describe "changing households" do
      let(:m) { Factory(:member) }

      it "should not allow last member to leave household with outstanding balance" do
        m.household.credit!(5)
        m.household= @household
        m.should_not be_valid
      end

      it "should allow last member to leave household with no outstanding balance" do
        m.household.credit!(5)
        m.household.debit!(5)
        m.household= @household
        m.should be_valid
      end

    end

  end

end

# == Schema Information
#
# Table name: members
#
#  id           :integer(4)      not null, primary key
#  last_name    :string(255)
#  first_name   :string(255)
#  household_id :integer(4)
#  created_at   :datetime
#  updated_at   :datetime
#  phone1       :string(255)
#  phone2       :string(255)
#  address1     :string(255)
#  address2     :string(255)
#  city         :string(255)
#  state        :string(255)
#  zip          :string(255)
#  notes        :text
#  active       :boolean(1)      default(TRUE)
#  email        :string(255)
#  fm_id        :integer(4)
#

