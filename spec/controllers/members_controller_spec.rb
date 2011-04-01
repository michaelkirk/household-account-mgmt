require 'spec_helper'

describe MembersController do
  fixtures :households
  before do
    controller.class.skip_before_filter :authenticate_user!
  end

  describe "#create " do
    it "should succeed" do
      Member.any_instance.stubs(:valid?).returns(true)
      HouseholdMembershipAudit.any_instance.stubs(:valid?).returns(true)
      post 'create'
      response.should redirect_to(assigns[:member])
    end
  end

end
