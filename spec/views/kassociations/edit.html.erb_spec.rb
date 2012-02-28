require 'spec_helper'

describe "kassociations/edit.html.erb" do
  before(:each) do
    @kassociation = assign(:kassociation, stub_model(Kassociation,
      :typus => "MyString",
      :description => "MyText",
      :source => nil,
      :target => nil
    ))
  end

  it "renders the edit kassociation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => kassociations_path(@kassociation), :method => "post" do
      assert_select "input#kassociation_typus", :name => "kassociation[typus]"
      assert_select "textarea#kassociation_description", :name => "kassociation[description]"
      assert_select "input#kassociation_source", :name => "kassociation[source]"
      assert_select "input#kassociation_target", :name => "kassociation[target]"
    end
  end
end
