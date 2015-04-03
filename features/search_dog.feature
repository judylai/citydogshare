Feature: Users should be able to search for a dog

As a dog-sitter
In order to sit a dog
I would like to search for dogs to sit

Background: user has been added to the database and logged in
  Given the following users exist:
    | last_name  | first_name | location              | gender | image                      | status  | phone_number  | email                           | description  | availability   |
    | Wayne      | Bruce      | Bat Cave, Gotham City | male   | http://tinyurl.com/opnc38n | looking | (555)228-6261 | not_batman@wayneenterprises.com | I love bats  | not nights     |
    | Pinzon     | Juan       | Berkeley, California  | male   | http://tinyurl.com/okrw3vd | looking | (555)123-1234 | student2@berkeley.edu           | I love dogs  | not mornings   |
  
  And the following dogs exist:
    | name     | mix              | age | size   | status             | gender | health | fixed | description                     | likes                      | energy_level   | location      | zipcode | image       | barks | personality |
    | Princess | Labrador         | 4   | small (0-15) | I'm a bonehead     | Female | none          |  yes  | Healthy and well-behaved dog.   | Cats, Men                      | high energy    | 1234 Berkeley | 94103   | doggy1.png | not much | whatever |
    | Spock    | Corgi            | 3   | medium (16-40)  | Treat, Don't Trick | Male   | none          |  no   | Goofy, energetic, and fearless. | Dogs (all) | Zzzzz | 5312 Berkeley | 94103   | doggy2.png | at the door | lover |

  And I am on the search dogs page

Scenario: View all dogs
  Then I should see "Princess"
  And I should see "Spock"

Scenario: Filter by gender
  When I check "gender[Male]"
  And I uncheck "gender[Female]"
  And I press "Search Dogs"
  Then I should see "Spock"
  And I should not see "Princess"

Scenario: No dogs match criteria
  When I check "size[large (41-100)]"
  And I press "Search Dogs"
  Then I should see "No Dogs Found"

