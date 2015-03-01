Feature: User should be able to view their dog's profile


As a dog parent
In order to make sure my dog’s information is correct
I want to view my dog’s profile

Background: user and user's dog have been added to the database and logged in

	Given the following users exist:
		| last_name | first_name | location | gender | status             | phone_number | email                 | description  | availability     |
    		| Pinzon    | Juan       | Berkeley | male   | looking, providing | 475-545-0099 | student1@berkeley.edu | I love dogs. | all the time     |
    		| Boggess   | Matthew    | Berkeley | male   | looking            | 474-545-0099 | student2@berkeley.edu | I love cats. | some of the time |

	And the following dogs exist:     
		| owner_email           | name     | mix                  | age | allergies | size   | motto                  | gender | neutered | description                     | likes    | dislikes                    |
		| student1@berkeley.edu | Princess | labrador             | 4   | none      | medium | I'm a bonehead         | female | yes      | Healthy and well-behaved dog.   | bones    | staying inside for too long |
		| student2@berkeley.edu | Fido 	   | Golden Retriever     | 3   | none      | medium | Treat, Don't Trick     | male   | yes      | Healthy and well-behaved dog.   | bones    | Thunderstorms               |
	
	And I have logged in as "student1@berkeley.edu"
	And I have viewed my profile information

Scenario: View User’s dog’s profile information
	Given I am on my profile page
	When I click on Fido’s picture
	Then I should see “Fido”
	And I should see “3 years old”
	And I should see “Golden Retriever”
	And I should see “Medium”
	And I should see "Male"
	And I should see “Treat, Don’t Trick”
	And I should see “Thunderstorms”
	And I should not see "I'm a bonehead"




