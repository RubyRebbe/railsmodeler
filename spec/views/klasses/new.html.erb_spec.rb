require 'spec_helper'

describe "klasses/new.html.erb" do
  before(:each) do
    assign(:klass, stub_model(Klass,
      :name => "MyString",
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new klass form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => klasses_path, :method => "post" do
      assert_select "input#klass_name", :name => "klass[name]"
      assert_select "textarea#klass_description", :name => "klass[description]"
    end
  end
end
