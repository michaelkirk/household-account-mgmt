Given /^a new Household$/ do
  @household = Household.create!
end

When /^I look at the household's balance$/ do
  @see = @household.balance
end

When /^I deposit \$(\d+) into the household's account$/ do |money|
  @household.credit!(BigDecimal.new(money))
end

Then /^I should see \$(\d+?)$/ do |money|
  @see.should == BigDecimal.new(money)
end

