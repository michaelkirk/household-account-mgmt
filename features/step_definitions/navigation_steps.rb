When /^I search for "([^"]*)"$/ do |term|
  step "I fill in \"#{term}\" for \"search\""
  step "I press \"Filter\""
end
