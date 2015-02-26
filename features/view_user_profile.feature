Feature: Users should be able to view their profile.

As a personal user
So that I can verify that my information is correct
I should be able to view the current state of my profile

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

Scenario: view user profile information
  Given I am on the CityDogShare home page
  When I press "view profile"
  Then I should see "Juan Pinzon"
  And I should see "Berkeley"
  And I should see "Male"
  And I should see "Looking and Providing"
  And I should see "(475) 545-0099"
  And I should see "student1@berkeley.edu"
  And I should see "I love dogs."
  And I should see "All the time."
  And I should see "Princess"
  And I should not see "Fido"
  
