Feature: Users should be able to create their profile.

As a new, non-professional user
In order to find a dog-sitter
I want to create a profile on City Dog Share

Background: User is not in the database but some other users and dogs are
  Given the following users exist:
    | last_name | first_name | location | gender | status             | phone_number | email                 | description  | availability     |
    | Pinzon    | Juan       | Berkeley | male   | looking, providing | 475-545-0099 | student1@berkeley.edu | I love dogs. | all the time     |
    | Boggess   | Matthew    | Berkeley | male   | looking            | 474-545-0099 | student2@berkeley.edu | I love cats. | some of the time |
  And the following dogs exist:
    | owner_email           | name     | mix              | age | allergies | size   | motto              | gender | neutered | description                     | likes                      | dislikes                    |
    | student1@berkeley.edu | Princess | labrador         | 4   | none      | medium | I'm a bonehead     | female | yes      | Healthy and well-behaved dog.   | bones                      | staying inside for too long |
    | student2@berkeley.edu | Fido     | golden retreiver | 3   | none      | medium | Treat, Don't Trick | male   | no       | Goofy, energetic, and fearless. | adventure and the outdoors | thunder storms              |
  And I am on the create profile form

Scenario: page shows error when all required fields are not filled
  When I press "Save Changes"
  Then I should see "Please fill out all required fields"
  And I should see all required fields highlighted

Scenario: page shows error when some required fields are not filled
  When I fill out "First Name" with "Michelle"
  And I fill out "Email" with "student3@berkeley.edu"
  And I press "Save Changes"
  Then I should see "Please fill out all required fields"
  And I should see these required fields highlighted: "Last Name", "Location", "Gender"

Scenario: successfully create user profile
  When I fill out "First Name" with "Michelle"
  And I fill out "Last Name" with "Nguyen"
  And I fill out "Email" with "student3@berkeley.edu"
  And I fill out "Location" with "Berkeley"
  And I check "Gender" as "Female"
  And I press "Save Changes"
  Then the profile for "student3@berkeley.edu" should exist

Scenario: attempt to create profile with used email
  When I fill out "First Name" with "Michelle"
  And I fill out "Last Name" with "Nguyen"
  And I fill out "Email" with "student2@berkeley.edu"
  And I fill out "Location" with "Berkeley"
  And I check "Gender" as "Female"
  And I press "Save Changes"
  Then I should see "An account already exists for the given email."
