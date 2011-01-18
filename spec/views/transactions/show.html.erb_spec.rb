require 'spec_helper'

describe "transactions/show.html.erb" do
  before(:each) do
    @household = assign(:household, stub_model(Household, {:id => 1}))

    @transaction = assign(:transaction, stub_model(Transaction,
      :amount => "9.99",
      :credit => false,
      :message => "Message",
      :household_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/9.99/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Message/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
