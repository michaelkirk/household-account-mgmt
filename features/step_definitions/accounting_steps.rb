When /^I deposit \$(\d+) into the household's account$/ do |amount|
  @household.credit!(BigDecimal.new(amount))
end

When /^that household spends \$(\d+)$/ do |amount|
  @household.debit!(BigDecimal.new(amount))
end

Given /^that household spent \$(\d+) a week ago$/ do |amount|
  Factory(:purchase, :household => @household, :amount => amount,:created_at => 7.days.ago )
end
