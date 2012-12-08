When /^I cross "(.*?)"$/ do |task|
  page.find(:xpath, "//span[text()='#{task}']").find(:xpath, "..").find(".task-done").set(true)
end

Then /^"(.*?)" should be crossed$/ do |task|
  page.find(:xpath, "//span[text()='#{task}']").find(:xpath, "..").find(".task-done").should be_checked
end

When /^I create task "(.*?)" with due date "(.*?)" and priority "(.*?)"$/ do |description, due_date, priority|
  fill_in "description", :with => description
  fill_in "due-date", :with => due_date
  fill_in "priority", :with => priority
  click_button "create-task"
end

Then /^I should see task "(.*?)"$/ do |description|
  page.should have_xpath "//span[text()='#{description}']"
end

Then /^I should see task "(.*?)" with due date "(.*?)"$/ do |desc, due_date|
  page.should have_xpath "//span[text()='#{desc}']"
  page.find(:xpath, "//span[text()='#{desc}']").find(:xpath, "..").should have_content due_date
end

Then /^I should see task "(.*?)" with due date "(.*?)" and priority "(.*?)"$/ do |desc, due_date, priority|
  #page.should have_xpath "//span[text()='#{desc}']"
  taskEl = page.find(:xpath, "//span[text()='#{desc}']").find(:xpath, "..")
  taskEl.should have_content due_date
  taskEl.should have_content priority
end

When /^I remove task "(.*?)"$/ do |task|
  page.find(:xpath, "//span[text()='#{task}']").find(:xpath, "..").find(".remove").click
end

When /^I edit task "(.*?)" with description "(.*?)", due date "(.*?)" and priority "(.*?)"$/ do |task, desc, due_date, priority|
  taskEl = page.find(:xpath, "//span[text()='#{task}']").find(:xpath, "..")
  taskEl.find(".desc").trigger("click")
  taskEl.find("input.desc").set(desc)
  taskEl.find(".due-date").trigger("click")
  taskEl.find("input.due-date").set(due_date)
  taskEl.find(".priority").trigger("click")
  taskEl.find("input.priority").set(priority)
end

# When /^I edit task "(.*?)" with description "(.*?)", due date "(.*?)" and priority "(.*?)"$/ do |task, desc, due_date, priority|
#   taskEl = page.find(:xpath, "//span[text()='#{task}']").find(:xpath, "..")
#   taskEl.find(".desc").trigger("click")
#   taskEl.find("input.desc").set(desc)
#   taskEl.find(".due-date").trigger("click")
#   taskEl.find("input.due-date").set(due_date)
#   taskEl.find(".priority").trigger("click")
#   taskEl.find("input.priority").set(priority)
# end

When /^I sort by priority$/ do
  find("#sort-by-priority").click
end

When /^I sort by due date$/ do
  find("#sort-by-due-date").click
end

Then /^my tasks should be sorted in this order:$/ do |table|
  page.all(".desc").collect(&:text).should === table.raw
end
    
