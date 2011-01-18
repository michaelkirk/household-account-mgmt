require 'spec_helper'

describe "Transactions" do
  before do
    @household = stub_model(Household, {:id => 1})
    Household.create!(:id=>1)
  end
  describe "GET /transactions" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get household_transactions_path(@household)
      response.status.should be(200)
    end
  end
end
