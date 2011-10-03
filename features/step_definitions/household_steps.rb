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
