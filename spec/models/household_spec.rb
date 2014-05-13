require 'spec_helper'

describe Household do
  it "should default to a $0.00 balance" do
    Household.create!.balance.should == 0
  end
  describe ".no_recent_activity" do
    it "should include households with transactions older than six months and households with no transactions" do
      active_household = Household.create!
      active_household.credit!(5.00)

      inactive_household = Household.create!
      old_household = Household.create!
      Transaction.create!(household:old_household, amount:5.00, created_at:7.months.ago, credit:true)

      
      Household.no_recent_activity.should include inactive_household
      Household.no_recent_activity.should include old_household
      Household.no_recent_activity.length.should == 2
    end
  end

  describe ".recent_activity" do
    it "should only display households with transactions in the past 6 months" do
      active_household = Household.create!
      active_household.credit!(5.00)

      inactive_household = Household.create!
      old_household = Household.create!
      Transaction.create!(household:old_household, amount:5.00, created_at:7.months.ago, credit:true)


      Household.recent_activity.should == [active_household]
    end
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

  describe ".find_by_keywords" do
    before(:all) do
      @households = []
      @members = []
      @households << @joe_and_sams_house = Factory.create(:household)
      @members << Factory.create(:member, first_name: "Joseph", household: @joe_and_sams_house)
      @members << Factory.create(:member, first_name: "Sam", household: @joe_and_sams_house)

      @households << @samanthas_house = Factory.create(:household)
      @members << Factory.create(:member, first_name: "Samantha", last_name: "Pierce", household: @samanthas_house)
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

