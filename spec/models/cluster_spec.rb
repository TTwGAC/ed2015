# encoding: utf-8
require 'spec_helper'

describe Cluster do
  describe '#next_cluster' do
    before :each do
      Cluster.create name: 'One', sequence: 1, color: 'blue'
      Cluster.create name: 'Ignore', sequence: 4, color: 'red'
      Cluster.create name: 'Two', sequence: 3, color: 'red'
    end

    after :each do
      Cluster.delete_all
    end

    let(:first_cluster) { Cluster.where(name: 'One').first }
    let(:last_cluster) { Cluster.order('sequence').last }

    it "should return the next highest cluster when ordered linearly" do
      first_cluster.next_cluster.should == Cluster.where(name: 'Two').first
    end

    it "should return the next highest cluster when there is a gap in the numbering" do
      first_cluster.next_cluster.should == Cluster.where(name: 'Two').first
    end

    it "should return nil when it is the final cluster" do
      last_cluster.next_cluster.should be_nil
    end
  end
end

# ## Schema Information
#
# Table name: `clusters`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `integer`          | `not null, primary key`
# **`name`**        | `string(255)`      |
# **`sequence`**    | `integer`          |
# **`color`**       | `string(255)`      | `default("red")`
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
#
