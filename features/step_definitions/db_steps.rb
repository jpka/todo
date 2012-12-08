Given /^I have a user "(.*?)" with password "(.*?)"$/ do |username, password|
  add_user username, password
end

Given /^the database is empty$/ do
  reset_db
end

Given /^user "(.*?)" has a task with description "(.*?)"$/ do |username, desc|
  add_task username, desc, 0
end

Given /^there are no tasks stored$/ do
  tasks_coll.remove
end