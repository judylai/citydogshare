Feature: Create a new City Dog Share Account
As a new user
So that I can use City Dog Share
I want to be able to create my account after authenticating with facebook

  Background:
    Given I follow "Sign Up With Facebook"
    And I am on the create new user page

  Scenario: Create account with all form fields filled in valid
    When I fill in valid information
    And I press "Create Account"
    Then I should be on the users page for "Batman"


  Scenario: Cancel account creation
    When I press "Cancel"
    Then I should be on the home page
    And I should see "Sign Up With Facebook"
 
  

