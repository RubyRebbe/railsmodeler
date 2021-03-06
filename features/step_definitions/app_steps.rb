Given /^there are no apps$/ do
	App.delete_all
end

Then /^I see no apps$/ do
 App.all.empty?.should == true
end

Given /^that there is no app with the name "([^"]*)"$/ do |appname|
	@appname = appname
  App.find_by_name( appname).should == nil
end

Then /^there exists an app with the name "([^"]*)"$/ do |appname|
  App.find_by_name( appname).name.should == @appname
end

Given /^I have the following database\-engines available:$/ do |table|
  @db_engines = table.raw.flatten
end

Then /^the app with name "([^"]*)" has database "([^"]*)"$/ do |appname, db|
  app = App.find_by_name( appname)
	app.database.should == db
end

