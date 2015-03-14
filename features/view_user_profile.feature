@facebook_test
Feature: Users should be able to view their profile.

As a personal user
So that I can verify that my information is correct
I should be able to view the current state of my profile

Background: user has been added to the database and logged in
  Given the following users exist:
    | last_name  | first_name | location              | gender | image                      | status  | phone_number  | email                           | description  | availability   |
    | Wayne      | Bruce      | Bat Cave, Gotham City | male   | http://tinyurl.com/opnc38n | looking | (555)228-6261 | not_batman@wayneenterprises.com | I love bats  | not nights     |
    | Pinzon     | Juan       | Berkeley, California  | male   | http://tinyurl.com/okrw3vd | looking | (555)123-1234 | student1@berkeley.edu           | I love dogs  | not mornings   |
  And I am logged in

Scenario: View user profile information
  Given I am on the users page for "Batman"
  Then I should see "Bruce Wayne"
  And I should see "Bat Cave, Gotham City"
  And I should see "male"
  And I should see "looking"
  And I should see "(555)228-6261"
  And I should see "not_batman@wayneenterprises.com"
  And I should see "I love bats"
  And I should see "not nights"
