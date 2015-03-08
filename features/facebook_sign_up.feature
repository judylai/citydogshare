Feature: New user can sign up with City Dog Share using a facebook account
  As a new CityDogUser user
  So that I can quickly sing up and find a dog-sitter
  I want to sign up with City Dog Share using my facebook account

Background:
	Given I am on the CityDogShare home page 
	
#Scenario: sign up with facebook if I have not sign in to Facebook
#	When I fill in "Email" and "Password"
#	And I press "Log in"
#	Then I should be on the CityDogShare home page
#	And I should see "Signed in as" "user_name" on Facebook

Scenario: sign up with facebook if I have sign in to Facebook
	And I press "Sign up with Facebook"
	And Facebook authorizes me
	Then I should be on the account creation page

Scenario: sign up with facebook if I already have an account
	And I press "Sign up with Facebook"
	And Facebook authorizes me
	Then I should see "You already have an account on City Dog Share."
	And I should be on the CityDogShare home page
	And I should see "Signed in as"