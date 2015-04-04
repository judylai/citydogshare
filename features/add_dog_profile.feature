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
  And I select "2010" from "dog_dob_1i"
  And I select "December" from "dog_dob_2i"
  And I select "4" from "dog_dob_3i"
  And I select "Male" from "dog_gender"
  And I select "medium (16-40)" from "dog_size"
  And I check "personalities_curious"
  And I fill in "dog_motto" with "Live long and play fetch."
  And I fill in "dog_description" with "Spock is out of this world. He even speaks Klingon"
  And I select "good" from "dog_energy_level"
  And I check "likes_cats"
  And I fill in "dog_health" with "none"
  And I choose "dog_fixed_true"
  And I fill in "dog_availability" with "Mondays and Weekends!"
  And I push "Save Changes"
  Then I should be on the users page for "Batman"

Scenario: make sure new dog shows up in user profile
  When I create a new dog "Spock"
  And I am on the users page for "Batman"
  And I should see "Spock"

Scenario: view dog profile
  When I create a new dog "Spock"
  And I am on the users page for "Batman"
  And I follow "Spock"
  Then I should see "Hi, I'm Spock"
  And I should see "Mix: Affenpinscher"
  And I should see "Age: 5"
  And I should see "Size: small (0-15)"

