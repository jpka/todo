Feature: Task Handling
  In order to get things done
  As a busy fellow
  I want to manage my tasks

  Background:
    Given I have a user "test" with password "secret"
    And user "test" has a task with description "laundry"
    And user "test" has a task with description "eat"

  Scenario: Task listing
    When I log in with "test" and "secret"
    Then I should see "laundry"
    And I should see "eat"

  Scenario: Task listing when reloading
    Given I am logged in with "test" and "secret"
    When I reload the page
    Then I should see "laundry"

  Scenario Outline: Task creation
    Given I log in with "test" and "secret"
    When I create task <description> with due date <due date> and priority <priority>
    Then I should see <something>

    Examples:
     | description |  due date  | priority |                         something                          |  
     |     ""      |     ""     |    ""    |                 "Description is required"                  |  
     | "wash car"  |     ""     |    ""    |                      task "wash car"                       |  
     | "wash car"  | "10/10/10" |    ""    |          task "wash car" with due date "2010-10-10"        |  
     | "wash car"  | "10/10/10" |   "10"   | task "wash car" with due date "2010-10-10" and priority "10"|  

  Scenario: Task creation persistance
    Given I log in with "test" and "secret"
    When I create task "task" with due date "10/10/10" and priority "3"
    And I reload the page
    Then I should see task "task" with due date "2010-10-10" and priority "3"

  Scenario: Task crossing
    Given I log in with "test" and "secret"
    When I cross "laundry"
    And I reload the page
    Then "laundry" should be crossed

  Scenario: Task removal
    Given I log in with "test" and "secret"
    When I remove task "laundry"
    Then I should not see "laundry"

    When I reload the page
    Then I should not see "laundry"

  Scenario: Task editing
    Given I log in with "test" and "secret"
    When I edit task "laundry" with description "Do laundry", due date "10/10/10" and priority "3"
    Then I should see task "Do laundry" with due date "2010-10-10" and priority "3"

    When I reload the page
    Then I should see task "Do laundry" with due date "2010-10-10" and priority "3"

    When I edit task "Do laundry" with description "", due date "10/10/10" and priority "3"
    #Then I should see "Do laundry"

    When I reload the page
    Then I should see "Do laundry"

  Scenario: Sorting
    Given there are no tasks stored
    And I log in with "test" and "secret"
    And I create task "task" with due date "10/12/10" and priority "3"
    And I create task "task2" with due date "10/10/10" and priority "1"
    And I create task "task3" with due date "10/11/11" and priority "2"

    When I sort by priority
    Then my tasks should be sorted in this order:
      | task  |  
      | task3 |  
      | task2 |  

    When I sort by priority
    Then my tasks should be sorted in this order:
      | task2 |  
      | task3 |  
      | task  |  

    When I sort by due date
    Then my tasks should be sorted in this order:
      | task2 |  
      | task  |  
      | task3 |  

    When I sort by due date
    Then my tasks should be sorted in this order:
      | task3 |  
      | task  |  
      | task2 |  

