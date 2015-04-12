@facebook_test
Feature: User should be able to share their dog by adding an event

As a dog parent
In order to find a sitter on a specific day
I want to post a dog event that others can see

Background: user has been added to the database and logged in
  Given the following users exist:
    | last_name  | first_name | location              | gender | image                      | status  | phone_number  | email                           | description  | availability   | address       | zipcode | city     | country | id |
    | Wayne      | Bruce      | Bat Cave, Gotham City | male   | http://tinyurl.com/opnc38n | looking | (555)228-6261 | not_batman@wayneenterprises.com | I love bats  | not nights     | 387 Soda Hall | 94720   | Berkeley | US      | 1  |
    | Pinzon     | Juan       | Berkeley, California  | male   | http://tinyurl.com/okrw3vd | looking | (555)123-1234 | student2@berkeley.edu           | I love dogs  | not mornings   | 387 Cory Hall | 94720   | Berkeley | US      | 2  |
  
  And the following dogs exist:
    | name     | mix              | age | size            | gender | likes      | energy  | personality | user_id |
    | Princess | Labrador         | 1   | small (0-15)    | Female | cats       | high    | whatever    | 1       |
    | Spock    | Aidi             | 3   | medium (16-40)  | Male   | dogs (all) | some    | lover       | 2       |

	And I am logged in
  And I am the parent of the existing dogs
  And I am on the share dogs page

Scenario: Choose dog to share
  And I open the dropdown to choose a dog
  And I click on "Princess"
  Then I should see "Princess" as the chosen dog

Scenario: Share one dog's event
  And I choose to share "Princess"
  And I choose the day "4/8/15"
  And I check "Morning, Afternoon"
  And I click "My location"
  And I press "Share"
  Then I should be on the profile for "Princess"
  And I should see "Your event has been created"
  And I should see a new event on the dog profile

Scenario: Not all fields filled out for dog event
  And I choose to share "Princess"
  And I check "Morning, Afternoon"
  And I click "My location"
  And I press "Share"
  Then I should see "You must fill out all fields for the event."

