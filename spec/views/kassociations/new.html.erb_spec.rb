require 'spec_helper'

describe "kassociations/new.html.erb" do
  before(:each) do
    assign(:kassociation, stub_model(Kassociation,
      :typus => "MyString",
      :description => "MyText",
      :source => nil,
      :target => nil
    ).as_new_record)
  end

  it "renders new kassociation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => kassociations_path, :method => "post" do
      assert_select "input#kassociation_typus", :name => "kassociation[typus]"
      assert_select "textarea#kassociation_description", :name => "kassociation[description]"
      assert_select "input#kassociation_source", :name => "kassociation[source]"
      assert_select "input#kassociation_target", :name => "kassociation[target]"
    end
  end
end
