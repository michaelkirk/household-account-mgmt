When /^I deposit \$(\d+) into the household's account$/ do |amount|
  @household.transactions.create(amount: BigDecimal.new(amount), credit: true)
end

When /^that household spends \$(\d+)$/ do |amount|
  @household.transactions.create(amount: BigDecimal.new(amount), credit: false)
end

When /^I edit the last transaction$/ do
  transaction = Transaction.last
  household = transaction.household
  visit edit_household_transaction_path(household, transaction)
end

Given /^that household spent \$(\d+) over a week ago$/ do |amount|
  Factory(:purchase, :household => @household, :amount => amount,:created_at => 7.1.days.ago )
end

Given /^there was a "\$([^"]*)" purchase on "([^"]*)"$/ do |amount, date|
  amount = BigDecimal.new(amount)
  date = Date.parse(date)
  Transaction.create!(:amount => amount, :created_at => date, :credit => false, :household => some_household)
end

Given /^there was a "\$([^"]*)" investment on "([^"]*)"$/ do |amount, date|
  amount = BigDecimal.new(amount)
  date = Date.parse(date)
  Transaction.create!(:amount => amount, :created_at => date, :credit => true, :household => some_household)
end

Then /^I should see "([^"]*)" of purchases for "([^"]*)"$/ do |amount, month_and_year|
  Then "I should see #{amount}"
end

Then /^I should see "([^"]*)" of investments for "([^"]*)"$/ do |amount, month_and_year|
  Then "I should see #{amount}"
end

def some_household
  @some_household ||= Factory.create(:household)
end
