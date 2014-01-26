require 'spec_helper'

describe "clusters/edit" do
  pending
  before(:each) do
    @cluster = assign(:cluster, stub_model(Cluster,
      :name => "MyString",
      :order => 1
    ))
  end

  xit "renders the edit cluster form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", cluster_path(@cluster), "post" do
      assert_select "input#cluster_name[name=?]", "cluster[name]"
      assert_select "input#cluster_order[name=?]", "cluster[order]"
    end
  end
end
