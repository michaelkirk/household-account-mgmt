require 'spec_helper'

describe "Transactions" do
  before do
    @household = stub_model(Household, {:id => 1})

    TransactionsController.skip_before_filter :authenticate_user!
  end

  describe "GET /transactions" do
    it "works!" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get all_transactions_url
      response.status.should be(200)
    end
  end
  describe "GET /household/1/transactions" do
    it "works!" do
      expect(Household).to receive(:find).and_return @household
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get household_transactions_url(:household_id => 1)
      response.status.should be(200)
    end
  end

end
