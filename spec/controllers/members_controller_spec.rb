require 'spec_helper'

describe MembersController do
  before do
    controller.class.skip_before_filter :authenticate_user!
  end

  describe "index" do
    it "should allow csv download" do
      get :index, :format => :csv
      response.should be_success
    end
  end

end
