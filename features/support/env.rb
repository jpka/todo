begin require 'rspec/expectations'; rescue LoadError; require 'spec/expectations'; end
require 'capybara' 
require 'capybara/dsl' 
require 'capybara/cucumber'
require 'capybara/poltergeist'
# Capybara.register_driver :poltergeist do |app|
#   Capybara::Poltergeist::Driver.new(app, {:timeout => 10})
# end
Capybara.javascript_driver = :poltergeist
Capybara.default_driver = :poltergeist
Capybara.app_host = 'http://localhost/dev/todos/php/'
Capybara.default_wait_time = 5

class Fixtures

end

World(Capybara)