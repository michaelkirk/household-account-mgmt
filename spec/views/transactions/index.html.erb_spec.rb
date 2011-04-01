require 'spec_helper'

describe "transactions/index.html.erb" do
  before(:each) do
    @household = assign(:household, stub_model(Household, {:id => 1}))
    @created_date = DateTime.now
    assign(:transactions, [
      stub_model(Transaction,
        :amount => "9.99",
        :credit => false,
        :message => "Message",
        :created_at => @created_date,
        :household_id => 1
      ),
      stub_model(Transaction,
        :amount => "9.99",
        :credit => false,
        :message => "Message",
        :created_at => @created_date,
        :household_id => 1
      )
    ])
  end

  it "renders a list of transactions" do
    render

    assert_select "tr>td", :text => @created_date.to_formatted_s(:default), :count => 2
    assert_select "tr>td.money", :text => "$9.99", :count => 2
    assert_select "tr>td", :text => "purchase", :count => 2
    assert_select "tr>td", :text => "Message", :count => 2
  end
end
