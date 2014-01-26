require 'spec_helper'

describe "clusters/new" do
  before(:each) do
    assign(:cluster, stub_model(Cluster,
      :name => "MyString",
      :order => 1
    ).as_new_record)
  end

  xit "renders new cluster form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", clusters_path, "post" do
      assert_select "input#cluster_name[name=?]", "cluster[name]"
      assert_select "input#cluster_order[name=?]", "cluster[order]"
    end
  end
end
