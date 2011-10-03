require 'spec_helper'

describe MembersController do
  before do
    controller.class.skip_before_filter :authenticate_user!
  end

end
