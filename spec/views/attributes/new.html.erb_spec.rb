require 'spec_helper'

describe "attributes/new.html.erb" do
  before(:each) do
    assign(:attribute, stub_model(Attribute,
      :name => "MyString",
      :description => "MyText",
      :klass => nil
    ).as_new_record)
  end

  it "renders new attribute form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => attributes_path, :method => "post" do
      assert_select "input#attribute_name", :name => "attribute[name]"
      assert_select "textarea#attribute_description", :name => "attribute[description]"
      assert_select "input#attribute_klass", :name => "attribute[klass]"
    end
  end
end
