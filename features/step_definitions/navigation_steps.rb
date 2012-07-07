When /^I search for "([^"]*)"$/ do |term|
  step "I fill in \"#{term}\" for \"search\""
  step "I press \"Filter\""
end

When /^I select "([^"]*)"$/ do |field_name|
  field = page.find(:css, "[name=#{field_name.strip}]")
  field.set(true)
end

When /^I deselect "([^"]*)"$/ do |field_name|
  field = page.find(:css, "[name=#{field_name.strip}]")
  field.set(false)
end
