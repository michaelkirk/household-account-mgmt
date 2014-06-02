require 'spec_helper'

describe "transactions/index.html.erb" do
  before(:each) do
    @household = assign(:household, FactoryGirl.create(:household))
    @created_date = Time.zone.now
    assign(:transactions, [
      FactoryGirl.create(:transaction,
        :amount => "9.99",
        :credit => false,
        :message => "Message",
        :created_at => @created_date,
        :household_id => @household.id
      ),
      FactoryGirl.create(:transaction,
        :amount => "9.99",
        :credit => false,
        :message => "Message",
        :created_at => @created_date,
        :household_id => @household.id
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
