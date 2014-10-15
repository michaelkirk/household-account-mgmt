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

  describe "#last_transaction" do
    subject { household.last_transaction }

    let(:household) { FactoryGirl.create(:household) }
    context "with a couple transactions" do
      let!(:first_transaction) { FactoryGirl.create(:purchase, household: household) }
      let!(:second_transaction) { FactoryGirl.create(:purchase, household: household) }
      it { should == second_transaction }
    end
  end

  pending "should be impossible to change balance without creating a transaction"

  describe ".by_recent_activity" do
    subject { Household.by_recent_activity }

    let!(:never_seen_this_household) { FactoryGirl.create(:household) }

    let!(:saw_this_household_a_bit_ago) do
      FactoryGirl.create(:purchase).household
    end

    let!(:saw_this_household_just_now) do
      FactoryGirl.create(:purchase).household
    end

    it { should == [saw_this_household_just_now, saw_this_household_a_bit_ago] }
  end

  describe ".find_by_keywords" do
    before(:all) do
      @households = []
      @members = []
      @households << @joe_and_sams_house = FactoryGirl.create(:household)
      @members << FactoryGirl.create(:member, first_name: "Joseph", household: @joe_and_sams_house)
      @members << FactoryGirl.create(:member, first_name: "Sam", household: @joe_and_sams_house)

      @households << @samanthas_house = FactoryGirl.create(:household)
      @members << FactoryGirl.create(:member, first_name: "Samantha", last_name: "Pierce", household: @samanthas_house)
    end

    after(:all) do
      @households.each &:destroy
      @members.each &:destroy
    end

    describe "when given then empty string" do
      subject { Household.find_by_keywords("") }
      it { should include(@samanthas_house) }
      it { should include(@joe_and_sams_house) }
    end

    describe "member's name matches exactly" do
      subject { Household.find_by_keywords("Samantha") }
      it { should include(@samanthas_house) }
      it { should_not include(@joe_and_sams_house) }
    end

    describe "member's name matches partially" do
      subject { Household.find_by_keywords("Jos") }
      it { should include(@joe_and_sams_house) }
      it { should_not include(@samanthas_house) }
    end

    describe "name matches multiple households" do
      subject { Household.find_by_keywords("Sam") }
      it { should include(@samanthas_house) }
      it { should include(@joe_and_sams_house) }
    end

    describe "when name matches, but with different caps" do
      subject { Household.find_by_keywords("sam") }
      it { should include(@samanthas_house) }
      it { should include(@joe_and_sams_house) }
    end

    describe "when last name is matched" do
      subject { Household.find_by_keywords("Pierce") }
      it { should include(@samanthas_house) }
      it { should_not include(@joe_and_sams_house) }
    end

    describe "searching active households" do
      let(:inactive_member) { FactoryGirl.create(:member, :active => false) }
      describe "using an inactive household's member name" do
        let(:scope) { Household.active.find_by_keywords(inactive_member.first_name) }
        it { scope.should be_empty }
      end
    end

    describe "with mulitple keywords" do

      describe "when we're specifying first and last name" do
        subject { Household.find_by_keywords("sam pierce") }
        it { should include(@samanthas_house) }
        it { should include(@joe_and_sams_house) }
      end

      describe "when we're specifiying multiple first names" do
        subject { Household.find_by_keywords("Sam Joseph") }
        it { should include(@samanthas_house) }
        it { should include(@joe_and_sams_house) }
      end
    end
  end
end

# == Schema Information
#
# Table name: households
#
#  id         :integer(4)      not null, primary key
#  balance    :decimal(8, 2)   default(0.0)
#  created_at :datetime
#  updated_at :datetime
#  notes      :text
#  fm_id      :integer(4)
#

