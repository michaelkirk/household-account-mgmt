require 'spec_helper'

describe "Households" do
  before do
    HouseholdsController.skip_before_filter :authenticate_user!
  end
  describe "GET /households" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get households_path
      response.status.should be(200)
    end
  end
end
