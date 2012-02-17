Feature: programmer manages klasses (within an app)
	As a rails developer
	I want to manage (CRUD) klasses in an app (application
	in order to model my application domain

	Scenario: no klasses in the app
		Given there are no klasses in the app
		When I go to the app show page
		Then I see no klasses associated with the app

	Scenario: create a klass in an app
		Given there are no klasses in the app
		When I go the app edit page
			And I create the klass "Person"
			And I save the app
		
