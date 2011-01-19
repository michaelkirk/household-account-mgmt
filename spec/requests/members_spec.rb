describe 'Members' do
  before do
    Household.any_instance.stubs(:valid?).returns(true)
    Household.create!
  end

  describe 'POST /members' do
    it 'should assign a new household if none was specified' do
      post members_path, {:member => {:household_id => nil}}
      #the new member should be the only one in their new household
      assigns[:member].household.members.should == [assigns[:member]]
    end

    it 'should assign the existing household when specified' do
      Member.any_instance.stubs(:valid?).returns(true)
      post members_path, {:member => {:household_id => Household.first.id}}

      assigns[:member].household.should == Household.first
    end
  end

  describe 'PUT /members/<id>' do
    it "should move the member to the specified household" do
      household= Household.create!
      member= Member.create!

      put member_path(member), {:member => {:household_id => household.id}}

      #the new member should be the only one in their new household
      assigns[:member].household.should == household
    end

    it "should put the member in a new household if the specified household id is empty" do
      member = Member.create!(:household => Household.create!)

      #add a member to their household so we can make sure they've switched.
      member.household.members << Member.create! 
      member.household.save!

      put member_path(member), {:member => {:household_id => nil}}

      #the new member should be the only one in their new household
      assigns[:member].household.members.should == [assigns[:member]]
    end

  end
end

