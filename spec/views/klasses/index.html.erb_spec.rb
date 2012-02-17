require 'spec_helper'

describe "klasses/index.html.erb" do
  before(:each) do
    assign(:klasses, [
      stub_model(Klass,
        :name => "Name",
        :description => "MyText"
      ),
      stub_model(Klass,
        :name => "Name",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of klasses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
