@facebook_test
Feature: User can log in using facebook
  As a City Dog Share user
  In order to access my user information
  I want to log in to City Dog Share

Background:
  Given I am on the home page

Scenario: log in when I already have an account  
  Given the following users exist:
  | uid   | last_name  | first_name | location              | gender | image                      | status  | phone_number  | email                           | description  | availability | token     | expires_at   |
  | 12345 | Wayne      | Bruce      | Bat Cave, Gotham City | male   | http://tinyurl.com/opnc38n | looking | (555)228-6261 | not_batman@wayneenterprises.com | I love bats  | not nights   | ABCDEF... | 372015171602 |



  When I follow "Log in with Facebook"
  Then I should be on the home page
  And I should see "Welcome Bruce" 

Scenario: log in when account does not exist
  When I follow "Log in with Facebook"
  Then I should be on the home page
  And I should see "User does not exist"

Scenario: see myself logged in when on the homepage and already logged in
  Given the following users exist:
  | uid   | last_name  | first_name | location              | gender | image                      | status  | phone_number  | email                           | description  | availability | token     | expires_at   |
  | 12345 | Wayne      | Bruce      | Bat Cave, Gotham City | male   | http://tinyurl.com/opnc38n | looking | (555)228-6261 | not_batman@wayneenterprises.com | I love bats  | not nights   | ABCDEF... | 372015171602 |

  Given I am logged in
  Then I should see "Welcome Bruce"

Scenario: log out when logged in to the site
  Given the following users exist:
  | uid   | last_name  | first_name | location              | gender | image                      | status  | phone_number  | email                           | description  | availability | token     | expires_at   |
  | 12345 | Wayne      | Bruce      | Bat Cave, Gotham City | male   | http://tinyurl.com/opnc38n | looking | (555)228-6261 | not_batman@wayneenterprises.com | I love bats  | not nights   | ABCDEF... | 372015171602 |
  
  Given I am logged in
  When I follow "Log Out"
  Then I should be on the home page
  And I should see "Log in with Facebook"
