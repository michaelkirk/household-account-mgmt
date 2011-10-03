Given /^I am not logged in$/ do
  #not logged in by default, so do nothing
end

Given /^a user with email "([^"]*)" and password "([^"]*)"$/ do |email, password|
  User.create(:email => email, :password => password)
end
