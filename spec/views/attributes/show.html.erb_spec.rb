require 'spec_helper'

describe "attributes/show.html.erb" do
  before(:each) do
    @attribute = assign(:attribute, stub_model(Attribute,
      :name => "Name",
      :description => "MyText",
      :klass => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
