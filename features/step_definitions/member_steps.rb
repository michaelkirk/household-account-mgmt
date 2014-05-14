Given /^(.*) is an active member$/ do |name|
  first_name, last_name = name.split
  FactoryGirl.create(:member, :first_name => first_name, :last_name => last_name, :active => true)
end

Given /^(.*) is an inactive member$/ do |name|
  first_name, last_name = name.split
  FactoryGirl.create(:member, :first_name => first_name, :last_name => last_name, :active => false)
end

