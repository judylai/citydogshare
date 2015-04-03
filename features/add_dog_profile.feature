Feature: Users should be able to add their dog's profile

As a non-professional user
In order to share my dog
I want to make a profile for my dog

Background: user has been added to the database and logged in
  Given the following users exist:
    | last_name  | first_name | location              | gender | image                      | status  | phone_number  | email                           | description  | availability   |
    | Wayne      | Bruce      | Bat Cave, Gotham City | male   | http://tinyurl.com/opnc38n | looking | (555)228-6261 | not_batman@wayneenterprises.com | I love bats  | not nights     |
  And I am logged in
  And I am on the users page for "Batman"
  When I press "Add Dog"
  Then I should see "Edit Your Dog's Profile"

Scenario: page shows error when all required fields are not filled
  When I press "Save Changes"
  Then I should see "Name can't be blank"
  And I should see "Mix can't be blank"

Scenario: page shows error when some required fields are not filled
  When I fill in "dog_name" with "Spock"
  And I press "Save Changes"
  And I should see "Mix can't be blank"

Scenario: create dog profile
  When I fill in "dog_name" with "Spock"
  And I choose "Mix" as "Corgi"
  #And I fill in "Age" with "2"
  And I select "Small" as "Small"
  And I fill out "Status" with "Live long and play fetch."
  And I choose "Gender" as "Male"
  And I fill out "Healthy notes" as "none"
  And I choose "Fixed" as "Yes"
  And I fill out "Description" with "Very normal."
  And I fill out "Likes" with "Playing fetch"d
  And I fill out "Dislikes" with "Cats"
  And I fill out "energy_level" with "high energy"
  And I fill out "location" with "1234 Berkeley"
  And I fill out "pics" with "doggy1.png"
  And I press "Save Changes"
  Then I should see the dog profile for "Spock"

Scenario: make sure new dog shows up in user profile
  When I create a new dog "Spock"
  And I should see "Parents"
  When I click on "Juan"
  Then I should see the user profile for "Juan"
  And I should see "Spock"

