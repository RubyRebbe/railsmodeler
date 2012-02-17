Feature: programmer creates an app
	As a rails developer
	I want to create an app in rmodeler
	in order to reduce errors both in design and coding

	Scenario: empty app list
		Given there are no apps
		When I go to the app list
		Then I see no apps

	Scenario: the rails developer creates and names the app
		Given that there is no app with the name "blog"
		When I go to the app list
			And I follow "New App"
			And I fill in "Name" with "blog"
			And I press "Create"
		Then there exists an app with the name "blog"

	Scenario:	the rails developer selects the database engine
		Given that there is no app with the name "blog"
			And I have the following database-engines available:
			| mysql      |
			| oracle     |
			| postgresql |
			| sqlite3    |
			| frontbase  |
			| ibm_db     |
		When I go to the app list
			And I follow "New App"
			And I fill in "Name" with "blog"
			And I select "postgresql" from "app_database"
			And I press "Create"
		Then the app with name "blog" has database "postgresql"
		

	Scenario: the rails developer decides to use rspec for specification and test of objects

	Scenario: the rails developer decides to use cucumber for specification and acceptance test
