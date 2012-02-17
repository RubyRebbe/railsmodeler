require 'spec_helper'

describe "attributes/index.html.erb" do
  before(:each) do
    assign(:attributes, [
      stub_model(Attribute,
        :name => "Name",
        :description => "MyText",
        :klass => nil
      ),
      stub_model(Attribute,
        :name => "Name",
        :description => "MyText",
        :klass => nil
      )
    ])
  end

  it "renders a list of attributes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
