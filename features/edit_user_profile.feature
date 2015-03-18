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

Scenario: Page shows error when required fields are made blank
  When I fill out "Location" with ""
  And I fill out "Availability" with ""
  And I press "Save Changes"
  Then I should see "Please fill out all required fields"
  And I should see "Location" and "Availability" highlighted

Scenario: Sucessfully update profile
  When I fill out "Location" with "San Francisco, California"
  And I fill out "Status" with "Sharing"
  And I fill out "Description" with "I think I should make City Bat Share."
  And I fill out "Availability" with "Never"
  And I press "Save Changes"
  Then I should be on the users page for "Batman"
  And I should see "San Francisco, California"
  And I shuld see "Sharing"
  And I should see "I think I should make City Bat Share."
  And I should see "Never"