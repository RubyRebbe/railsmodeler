require 'spec_helper'

describe "attributes/edit.html.erb" do
  before(:each) do
    @attribute = assign(:attribute, stub_model(Attribute,
      :name => "MyString",
      :description => "MyText",
      :klass => nil
    ))
  end

  it "renders the edit attribute form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => attributes_path(@attribute), :method => "post" do
      assert_select "input#attribute_name", :name => "attribute[name]"
      assert_select "textarea#attribute_description", :name => "attribute[description]"
      assert_select "input#attribute_klass", :name => "attribute[klass]"
    end
  end
end
