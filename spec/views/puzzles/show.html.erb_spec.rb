require 'spec_helper'

describe "puzzles/show" do
  before(:each) do
    @puzzle = assign(:puzzle, stub_model(Puzzle))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
