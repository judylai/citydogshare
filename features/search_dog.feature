Feature: Users should be able to search for a dog

As a dog-sitter
In order to sit a dog
I would like to search for dogs to sit

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
  And I have logged in as "student2@berkeley.edu"
  And I have viewed my user profile information
  When I search for a dog
  Then I should see "Search for a Dog"


Scenario: Search for a dog 
  When I fill out "Age" with "3"
  And I choose "Size" as "small"
  And I choose "Gender" as "Male"
  And I choose "Mix" as "Corgi"
  And I fill out "Zipcode" with "94103"
  Adn I choose "Range" ad "5 miles"
  And I choose "Energy Level" as "sleeps all day" 
  And I choose "likes" as "adventure"
  Then I should see the dog profile for "Spock"
