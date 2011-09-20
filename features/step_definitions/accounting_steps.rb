Given /^a new Household$/ do
  @household = Household.new
end

When /^I look at the household's balance$/ do
  @see = @household.balance
end

Then /^I should see \$(\d+(\.\d+)?)$/ do |dollars, cents|
  if cents
    money = dollars + cents
  else
    money = dollars
  end
  @see.should == BigDecimal.new(money)
end
