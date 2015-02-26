Feature: Users should be able to add their dog's profile

As a non-professional user
In order to share my dog
I want to make a profile for my dog

Background: user has been added to the database and logged in
  Given the following users exist:
    | last_name | first_name | location | gender | status             | phone_number | email                 | description  | availability     |
    | Pinzon    | Juan       | Berkeley | male   | looking, providing | 475-545-0099 | student1@berkeley.edu | I love dogs. | all the time     |
    | Boggess   | Matthew    | Berkeley | male   | looking            | 474-545-0099 | student2@berkeley.edu | I love cats. | some of the time |
  And the following dogs exist:
    | owner_email           | name     | mix              | age | allergies | size   | motto              | gender | neutered | description                     | likes                      | dislikes                    |
    | student1@berkeley.edu | Princess | labrador         | 4   | none      | medium | I'm a bonehead     | female | yes      | Healthy and well-behaved dog.   | bones                      | staying inside for too long |
    | student2@berkeley.edu | Fido     | golden retreiver | 3   | none      | medium | Treat, Don't Trick | male   | no       | Goofy, energetic, and fearless. | adventure and the outdoors | thunder storms              |
  And I have logged in as "student1@berkeley.edu"
  And I have viewed my user profile information
  When I add a dog
  Then I should see "Edit Dog Profile"

Scenario: land on add dog page
  And all fields are empty

Scenario: page shows error when all required fields are not filled
  When I press "Save Changes"
  Then I should see "Please fill out all required fields"
  And I should see all required fields highlighted

Scenario: page shows error when some required fields are not filled
  When I fill out "Dog Name" with "Spock"
  And I fill out "Mix" with "Corgi"
  And I press "Save Changes"
  Then I should see "Please fill out all required fields"
  And I should see these required fields highlighted: "Size", "Gender", "Fixed"

Scenario: create dog profile
  When I fill out "Dog Name" with "Spock"
  And I fill out "Mix" with "Corgi"
  And I fill out "Age" with "2"
  And I choose "Size" as "Small"
  And I fill out "Motto" with "Live long and play fetch."
  And I check "Gender" as "Male"
  And I check "Fixed" with "Yes"
  And I fill out "Description" with "Very normal."
  And I fill out "Likes" with "Playing fetch"
  And I fill out "Dislikes" with "Cats"
  And I press "Save Changes"
  Then I should see the dog profile for "Spock"

Scenario: make sure new dog shows up in user profile
  When I create a new dog "Spock"
  And I should see "Parents"
  When I click on "Juan"
  Then I should see the user profile for "Juan"
  And I should see "Spock"