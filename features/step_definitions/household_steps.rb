Given /^a household with a \$(\d+) balance$/ do |balance|
  @household = Household.create!(:balance => BigDecimal(balance))
end

Given /^a new Household$/ do
  @household = Household.create!
end

When /^I view that household$/ do
  visit household_path(@household)
end

When /^I credit the household \$(\d+)$/ do |amount|
  choose "Credit"
  fill_in "Amount", :with => amount
  click_button "Save"
end

Then /^I should not see any members besides "([^"]*)"$/ do |member_names|
  members_names = member_names.split(" and ")

  page.all("#members li").count.should == members_names.count
  members_names.each_with_index do |name, index|
    page.all("#members li")[index].text.should == name
  end
end

Given /^a household with "([^"]*)" as a? ?members?$/ do |member_names|
  members_names = member_names.split(" and ")

  members = members_names.map do |member_name|
    first_name, last_name = member_name.split
    Factory(:member, :first_name => first_name, :last_name => last_name)
  end
  
  @household = Household.create!(:members => members)
end