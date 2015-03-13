@facebook_test
Feature: New user can sign up with City Dog Share using a facebook account
  As a new City Dog Share user
  So that I can use City Dog Share
  I want to sign up for City Dog Share using my facebook account

Background:
  Given I am on the home page
	
Scenario: Sign up with facebook if I am a new user
  When I follow "Sign Up With Facebook"
  Then I should be on the users page for "Batman"


Scenario: Sign up with facebook if I am an existing user
  Given the following users exist:
  | last_name  | first_name | location              | gender | image                      | status  | phone_number  | email                           | description  | availability |
  | Wayne      | Bruce      | Bat Cave, Gotham City | male   | http://tinyurl.com/opnc38n | looking | (555)228-6261 | not_batman@wayneenterprises.com | I love bats  | not nights   |
  When I follow "Sign Up With Facebook"
  Then I should be on the home page
  And I should see "A user already exists with this facebook account."

Scenario: Sign up authentication fails
  Given I am on the homepage
  When I follow "Sign Up With Facebook"
  And my authentication fails
  Then I should be on the home page
  And I should see "Something went wrong with the authentication. Please try again."

