require 'spec_helper'

describe "documents/show" do
  before(:each) do
    @document = assign(:document, stub_model(Document,
      :name => "Name",
      :description => "MyText",
      :private => false
    ))
  end

  xit "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
    rendered.should match(/false/)
  end
end
