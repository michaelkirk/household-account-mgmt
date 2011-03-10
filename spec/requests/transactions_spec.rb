require 'spec_helper'

describe "Transactions" do
  before do
    @household = stub_model(Household, {:id => 1})
    Household.create!(:id=>1)
    def current_user
      mock_model(User)
    end
  end

  describe "GET /transactions" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get all_transactions_url
      response.status.should be(200)
    end
  end
end
