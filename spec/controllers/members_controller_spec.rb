require 'spec_helper'

describe MembersController do
  fixtures :households

  describe "#create " do
    it "should succeed" do
      Member.any_instance.stubs(:valid?).returns(true)
      post 'create'
      response.should redirect_to(assigns[:member])
    end
  end

end
