require 'spec_helper'

describe "klasses/edit.html.erb" do
  before(:each) do
    @klass = assign(:klass, stub_model(Klass,
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit klass form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => klasses_path(@klass), :method => "post" do
      assert_select "input#klass_name", :name => "klass[name]"
      assert_select "textarea#klass_description", :name => "klass[description]"
    end
  end
end
