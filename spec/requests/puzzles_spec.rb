require 'spec_helper'

describe "Puzzles" do
  describe "GET /puzzles" do
    it "works! (now write some real specs)" do
      pending "Devise sign_in for request specs seems broken"
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get puzzles_path
      response.status.should be(200)
    end
  end
end
