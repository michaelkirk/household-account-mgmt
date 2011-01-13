require 'spec_helper'

describe "transactions/index.html.erb" do
  before(:each) do
    assign(:transactions, [
      stub_model(Transaction,
        :amount => "9.99",
        :credit => false,
        :message => "Message",
        :household_id => 1
      ),
      stub_model(Transaction,
        :amount => "9.99",
        :credit => false,
        :message => "Message",
        :household_id => 1
      )
    ])
  end

  it "renders a list of transactions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Message".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
