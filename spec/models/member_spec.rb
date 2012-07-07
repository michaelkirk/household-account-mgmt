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

  describe ".find_by_keywords" do
    before(:all) do
      @members = []
      @members << @joseph = Factory.create(:member, first_name: "Joseph")
      @members << @sam = Factory.create(:member, first_name: "Sam")
      @members << @samantha_pierce = Factory.create(:member, first_name: "Samantha", last_name: "Pierce")
    end

    after(:all) do
      @members.each &:destroy
    end

    describe "when given then empty string" do
      subject { Member.find_by_keywords("") }
      it { should include(@samantha_pierce) }
      it { should include(@joseph) }
      it { should include(@sam) }
    end

    describe "member's name matches exactly" do
      subject { Member.find_by_keywords("Samantha") }
      it { should include(@samantha_pierce) }
      it { should_not include(@joseph) }
      it { should_not include(@sam) }
    end

    describe "member's name matches partially" do
      subject { Member.find_by_keywords("Jos") }
      it { should include(@joseph) }
      it { should_not include(@samantha_pierce) }
      it { should_not include(@sam) }
    end

    describe "name matches multiple households" do
      subject { Member.find_by_keywords("Sam") }
      it { should include(@samantha_pierce) }
      it { should include(@sam) }
      it { should_not include(@joseph) }
    end

    describe "when name matches, but with different caps" do
      subject { Member.find_by_keywords("sam") }
      it { should include(@samantha_pierce) }
      it { should include(@sam) }
      it { should_not include(@joseph) }
    end

    describe "when last name is matched" do
      subject { Member.find_by_keywords("Pierce") }
      it { should include(@samantha_pierce) }
      it { should_not include(@joseph) }
      it { should_not include(@sam) }
    end

    describe "with mulitple keywords" do

      describe "when we're specifying first and last name" do
        subject { Member.find_by_keywords("sam pierce") }
        it { should include(@samantha_pierce) }
        it { should include(@sam) }
        it { should_not include(@joseph) }
        it "shouldn't include a member multiple times" do
          subject.length.should == 2
        end
      end

      describe "when we're specifiying multiple first names" do
        subject { Member.find_by_keywords("Sam Joseph") }
        it { should include(@samantha_pierce) }
        it { should include(@sam) }
        it { should include(@joseph) }
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

