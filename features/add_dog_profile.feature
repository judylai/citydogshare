Feature: Users should be able to add their dog's profile

As a non-professional user
In order to share my dog
I want to make a profile for my dog

Background: user has been added to the database and logged in
  Given the following users exist:
  Given the following users exist:
    | last_name  | first_name | location              | gender | image                      | status  | phone_number  | email                           | description  | availability   |
    | Wayne      | Bruce      | Bat Cave, Gotham City | male   | http://tinyurl.com/opnc38n | looking | (555)228-6261 | not_batman@wayneenterprises.com | I love bats  | not nights     |
    | Pinzon     | Juan       | Berkeley, California  | male   | http://tinyurl.com/okrw3vd | looking | (555)123-1234 | student2@berkeley.edu           | I love dogs  | not mornings   |
  And the following dogs exist:
    | owner_email           | name     | mix              | age | size   | status             | gender | healthy_notes | fixed | description                     | likes                      | dislikes                    | energy_level   | location      | zipcode | pics       |
    | student1@berkeley.edu | Princess | labrador         | 4   | medium | I'm a bonehead     | female | none          |  yes  | Healthy and well-behaved dog.   | bones                      | staying inside for too long | high energy    | 1234 Berkeley | 94103   | doggy1.png |
    | student2@berkeley.edu | Spock    | Corgi            | 3   | small  | Treat, Don't Trick | male   | none          |  no   | Goofy, energetic, and fearless. | adventure and the outdoors | thunder storms              | sleeps all day | 5312 Berkeley | 94103   | doggy2.png |
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
  And I choose "Mix" as "Corgi"
  And I fill out "Age" with "2"
  And I choose "Size" as "Small"
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