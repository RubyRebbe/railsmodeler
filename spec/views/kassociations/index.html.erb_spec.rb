require 'spec_helper'

describe "kassociations/index.html.erb" do
  before(:each) do
    assign(:kassociations, [
      stub_model(Kassociation,
        :typus => "Typus",
        :description => "MyText",
        :source => nil,
        :target => nil
      ),
      stub_model(Kassociation,
        :typus => "Typus",
        :description => "MyText",
        :source => nil,
        :target => nil
      )
    ])
  end

  it "renders a list of kassociations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Typus".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
