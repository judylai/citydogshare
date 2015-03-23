Feature: Users should be able to edit their profile.

As a user
In order to change my information
I want to edit my profile

Background: User and other users are in database
  Given the following users exist:
    | last_name  | first_name | location              | gender | image                      | status  | phone_number  | email                           | description  | availability   |
    | Wayne      | Bruce      | Bat Cave, Gotham City | male   | http://tinyurl.com/opnc38n | looking | (555)228-6261 | not_batman@wayneenterprises.com | I love bats  | not nights     |
    | Pinzon     | Juan       | Berkeley, California  | male   | http://tinyurl.com/okrw3vd | looking | (555)123-1234 | student1@berkeley.edu           | I love dogs  | not mornings   |
  And I am logged in
  And I am on the users page for "Batman"
  And I press "Edit"

Scenario: Page shows error when phone number is wrong format
  When I fill in "user_phone_number" with "1235"
  When I press "Save Changes"
  Then I should see "Bad format for phone number."

Scenario: Sucessfully update some of profile
  And I select "Sharing" from "user_status"
  And I fill in "user_description" with "I think I should make City Bat Share."
  And I press "Save Changes"
  Then I should be on the users page for "Batman"
  And I should see "Bat Cave, Gotham City"
  And I should see "(555)228-6261"
  And I should see "Sharing"
  And I should see "I think I should make City Bat Share."
  And I should see "not nights"

Scenario: Sucessfully update all of profile
  When I fill in "user_location" with "San Francisco, California"
  And I select "Sharing" from "user_status"
  And I fill in "user_phone_number" with "(510)123-1234"
  And I fill in "user_description" with "I think I should make City Bat Share."
  And I fill in "user_availability" with "Never"
  And I press "Save Changes"
  Then I should be on the users page for "Batman"
  And I should see "San Francisco, California"
  And I should see "Sharing"
  And I should see "(510)123-1234"
  And I should see "I think I should make City Bat Share."
  And I should see "Never"

Scenario: No changes made when changes canceled
  When I fill in "user_location" with "San Francisco, California"
  And I select "Sharing" from "user_status"
  And I fill in "user_phone_number" with "(510)123-1234"
  And I fill in "user_description" with "I think I should make City Bat Share."
  And I fill in "user_availability" with "Never"
  And I press "Cancel Changes"
  Then I should be on the users page for "Batman"
  And I should see "Bat Cave, Gotham City"
  And I should see "looking"
  And I should see "(555)228-6261"
  And I should see "I love bats"
  And I should see "not nights"