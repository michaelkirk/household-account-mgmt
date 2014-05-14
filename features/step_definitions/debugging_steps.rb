When /^I console$/ do
  binding.pry
end

Given /^"(.*)" made this pending on "(.*)" because "(.*)"$/ do |name, date, message|
  pending_date = Date.parse(date)
  raise "#{name} made this pending on #{date} because '#{message}' but that was more than 30 days ago. Consider deleting this test" if pending_date < 30.days.ago.to_date
  pending "#{date} - #{message} (#{name})"
end

And /I wait (\d+) second(?:s?)/ do |seconds|
  sleep(seconds.to_i)
end

And /^I debug$/ do
  debugger
end
