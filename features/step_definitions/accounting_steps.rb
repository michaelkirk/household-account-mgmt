When /^I deposit \$(\d+) into the household's account$/ do |money|
  @household.credit!(BigDecimal.new(money))
end

