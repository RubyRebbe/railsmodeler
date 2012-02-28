require 'spec_helper'

describe "kassociations/show.html.erb" do
  before(:each) do
    @kassociation = assign(:kassociation, stub_model(Kassociation,
      :typus => "Typus",
      :description => "MyText",
      :source => nil,
      :target => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Typus/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
