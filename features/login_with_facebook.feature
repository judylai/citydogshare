@facebook_test
Feature: User can log in using facebook
  As a user
  In order to visit the City Dog Share home page
  I want to log in to City Dog Share



Scenario:  
  Given the following users exist:
  | uid   | last_name  | first_name | location              | gender | image                      | status  | phone_number  | email                           | description  | availability | token     | expires_at   |
  | 12345 | Wayne      | Bruce      | Bat Cave, Gotham City | male   | http://tinyurl.com/opnc38n | looking | (555)228-6261 | not_batman@wayneenterprises.com | I love bats  | not nights   | ABCDEF... | 372015171602 |



  When I go to the home page
  And I follow "Log in with Facebook"
  Then I should be on the home page
  And I should see "Welcome Bruce" 

Scenario:
  Given that I am on the home page
  And I follow "Log in with Facebook"
  Then I should be on the home page
  And I should see "User does not exist"

Scenario: 
  Given the following users exist:
  | uid   | last_name  | first_name | location              | gender | image                      | status  | phone_number  | email                           | description  | availability | token     | expires_at   |
  | 12345 | Wayne      | Bruce      | Bat Cave, Gotham City | male   | http://tinyurl.com/opnc38n | looking | (555)228-6261 | not_batman@wayneenterprises.com | I love bats  | not nights   | ABCDEF... | 372015171602 |

  When I go to the homepage
  Then I should see "Welcome Bruce"

Scenario: 
  Given the following users exist:
  | uid   | last_name  | first_name | location              | gender | image                      | status  | phone_number  | email                           | description  | availability | token     | expires_at   |
  | 12345 | Wayne      | Bruce      | Bat Cave, Gotham City | male   | http://tinyurl.com/opnc38n | looking | (555)228-6261 | not_batman@wayneenterprises.com | I love bats  | not nights   | ABCDEF... | 372015171602 |
  
  Given that I am logged in
  When I go to the homepage
  And I follow "Log Out"
  Then I should see "Log in with Facebook"
