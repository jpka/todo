When /^I do nothing$/ do
end

When /^I visit the page$/ do
  visit "/"
end

When /^I reload the page$/ do
  visit "/"
end

Then /^I should see "(.*?)"$/ do |message|
  page.should have_content message
end

Then /^I should not see "(.*?)"$/ do |message|
  page.should_not have_content message
end

