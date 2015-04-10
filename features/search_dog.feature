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
    | name     | mix              | age | size            | gender | likes      | energy  | personality |
    | Princess | Labrador         | 1   | small (0-15)    | Female | cats       | high    | whatever    |
    | Spock    | Aidi             | 3   | medium (16-40)  | Male   | dogs (all) | some    | lover       |

  And I am on the search dogs page

Scenario: View all dogs
  Then I should see "Princess"
  And I should see "Spock"

Scenario: Filter by gender
  When I check "gender[Male]"
  And I press "Search Dogs"
  Then I should see "Spock"
  And I should not see "Princess"

Scenario: Filter by Age
  When I check "age[0]"
  And I press "Search Dogs"
  Then I should see "Princess"
  And I should not see "Spock"

Scenario: Filter by Size
  When I check "size[small (0-15)]"
  And I press "Search Dogs"
  Then I should see "Princess"
  And I should not see "Spock"

Scenario: Filter by Likes
  When I check "like[cats]"
  And I press "Search Dogs"
  Then I should see "Princess"
  And I should not see "Spock"

Scenario: Filter by Energy
  When I check "energy_level[high]"
  And I press "Search Dogs"
  Then I should see "Princess"
  And I should not see "Spock"

Scenario: Filter by Energy
  When I check "personality[whatever]"
  And I press "Search Dogs"
  Then I should see "Princess"
  And I should not see "Spock"

Scenario: Filter by Mix
  When I select "Labrador" from "mix"
  And I press "Search Dogs"
  Then I should see "Princess"
  And I should not see "Spock"

Scenario: No dogs match criteria
  When I check "size[large (41-100)]"
  And I press "Search Dogs"
  Then I should see "No Dogs Found"

