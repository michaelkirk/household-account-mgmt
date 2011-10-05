When /^I search for "([^"]*)"$/ do |term|
  When "I fill in \"#{term}\" for \"search\""
  And "I press \"Search\""
end