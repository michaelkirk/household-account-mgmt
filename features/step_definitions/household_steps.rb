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
  check "credit"
  fill_in "amount", :with => amount
  click_button "Save"
end
