Feature: New user can sign up with City Dog Share using a facebook account
  As a new CityDogUser user
  So that I can quickly sing up and find a dog-sitter
  I want to sign up with City Dog Share using my facebook account

Background:
	Given I am on the CityDogShare home page
	When I follow "Sign up with Facebook"
	Then I should be on the Facebook Login page 
	
Scenario: sign up with facebook if I have not sign in to Facebook
	When I fill in "Email" and "Password"
	And I press "Log in"
	Then I should be on the CityDogShare home page
	And I should see "Signed in as" "user_name" on Facebook


Scenario: sign up with facebook if I have sign in to Facebook
	And I press "Log in with Facebook"
	Then I should be on the CityDogShare home page
	And I should see "Signed in as" "user_name" on Facebook