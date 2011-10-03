Given /^I am logged in$/ do
  Given "I am not logged in"
  Given 'a user with email "somebody@foodlobby.org" and password "secret"'
  And "I am on the sign in page"
  When 'I fill in "somebody@foodlobby.org" for "Email"'
  And 'I fill in "secret" for "Password"'
  And 'I press "Sign in"'
end

Given /^I am not logged in$/ do
  #not logged in by default, so do nothing
end

Given /^a user with email "([^"]*)" and password "([^"]*)"$/ do |email, password|
  User.create!(:email => email, :password => password)
end
