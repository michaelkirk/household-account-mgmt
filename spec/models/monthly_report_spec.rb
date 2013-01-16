require "spec_helper"

describe MonthlyReport do

  describe "#purchases_amount" do
    subject { MonthlyReport.all.map &:purchases_amount }

    context "with 1 purchase" do
      before do
        Factory.create(:purchase, :amount => 50, :created_at => Date.parse("January 1, 2011"))
      end
      it {should == [50]}
    end

    context "with 2 purchases on the same day" do
      before do
        Factory.create(:purchase, :amount => 50, :created_at => Date.parse("January 1, 2011"))
        Factory.create(:purchase, :amount => 50, :created_at => Date.parse("January 1, 2011"))
      end
      it {should == [100]}
    end

    context "with 2 purchases on different days" do
      before do
        Factory.create(:purchase, :amount => 50, :created_at => Date.parse("January 1, 2011"))
        Factory.create(:purchase, :amount => 50, :created_at => Date.parse("January 31, 2011"))
      end
      it {should == [100]}
    end

    context "with a purchase from a different month" do
      before do
        Factory.create(:purchase, :amount => 50, :created_at => Date.parse("January 1, 2011"))
        Factory.create(:purchase, :amount => 50, :created_at => Date.parse("February 1, 2011"))
      end
      it {should == [50, 50]}
    end

    context "with a purchase from a different year" do
      before do
        Factory.create(:purchase, :amount => 50, :created_at => Date.parse("January 1, 2011"))
        Factory.create(:purchase, :amount => 50, :created_at => Date.parse("January 1, 2010"))
      end
      it {should == [50,50]}
    end
  end

  describe "#investments_amount" do
    subject { MonthlyReport.all.map &:investments_amount }

    context "with 1 investment" do
      before do
        Factory.create(:investment, :amount => 50, :created_at => Date.parse("January 1, 2011"))
      end
      it {should == [50]}
    end

    context "with 2 investments on the same day" do
      before do
        @transaction = Factory.create(:investment, :amount => 50, :created_at => Date.parse("January 1, 2011"))
        Factory.create(:investment, :amount => 50, :created_at => Date.parse("January 1, 2011"))
      end
      it {should == [100]}

      context "when one of those transactions is voided" do
        before do
          @transaction.void = true
          @transaction.save
        end
        it { should == [50] }
      end
    end

    context "with 2 investments on different days" do
      before do
        Factory.create(:investment, :amount => 50, :created_at => Date.parse("January 1, 2011"))
        Factory.create(:investment, :amount => 50, :created_at => Date.parse("January 31, 2011"))
      end
      it {should == [100]}
    end

    context "with a investment from a different month" do
      before do
        Factory.create(:investment, :amount => 50, :created_at => Date.parse("January 1, 2011"))
        Factory.create(:investment, :amount => 50, :created_at => Date.parse("February 1, 2011"))
      end
      it {should == [50, 50]}
    end

    context "with a investment from a different year" do
      before do
        Factory.create(:investment, :amount => 50, :created_at => Date.parse("January 1, 2011"))
        Factory.create(:investment, :amount => 50, :created_at => Date.parse("January 1, 2010"))
      end
      it {should == [50,50]}
    end

  end

end
