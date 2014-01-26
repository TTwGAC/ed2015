require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe ClustersController do

  # This should return the minimal set of attributes required to create a valid
  # Cluster. As you add validations to Cluster, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "name" => "MyString", "sequence" => 1, "color" => "blue" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ClustersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  include ControllerSpecMixin

  before :each do
    sign_in_as :admin
  end


  describe "GET index" do
    it "assigns all clusters as @clusters" do
      cluster = Cluster.create! valid_attributes
      get :index, {}, valid_session
      assigns(:clusters).should eq([cluster])
    end
  end

  describe "GET show" do
    it "assigns the requested cluster as @cluster" do
      cluster = Cluster.create! valid_attributes
      get :show, {:id => cluster.to_param}, valid_session
      assigns(:cluster).should eq(cluster)
    end
  end

  describe "GET new" do
    it "assigns a new cluster as @cluster" do
      get :new, {}, valid_session
      assigns(:cluster).should be_a_new(Cluster)
    end
  end

  describe "GET edit" do
    it "assigns the requested cluster as @cluster" do
      cluster = Cluster.create! valid_attributes
      get :edit, {:id => cluster.to_param}, valid_session
      assigns(:cluster).should eq(cluster)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Cluster" do
        expect {
          post :create, {:cluster => valid_attributes}, valid_session
        }.to change(Cluster, :count).by(1)
      end

      it "assigns a newly created cluster as @cluster" do
        post :create, {:cluster => valid_attributes}, valid_session
        assigns(:cluster).should be_a(Cluster)
        assigns(:cluster).should be_persisted
      end

      it "redirects to the created cluster" do
        post :create, {:cluster => valid_attributes}, valid_session
        response.should redirect_to(Cluster.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved cluster as @cluster" do
        # Trigger the behavior that occurs when invalid params are submitted
        Cluster.any_instance.stub(:save).and_return(false)
        post :create, {:cluster => { "name" => "invalid value" }}, valid_session
        assigns(:cluster).should be_a_new(Cluster)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Cluster.any_instance.stub(:save).and_return(false)
        post :create, {:cluster => { "name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested cluster" do
        cluster = Cluster.create! valid_attributes
        # Assuming there are no other clusters in the database, this
        # specifies that the Cluster created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Cluster.any_instance.should_receive(:update_attributes).with({ "name" => "MyString" })
        put :update, {:id => cluster.to_param, :cluster => { "name" => "MyString" }}, valid_session
      end

      it "assigns the requested cluster as @cluster" do
        cluster = Cluster.create! valid_attributes
        put :update, {:id => cluster.to_param, :cluster => valid_attributes}, valid_session
        assigns(:cluster).should eq(cluster)
      end

      it "redirects to the cluster" do
        cluster = Cluster.create! valid_attributes
        put :update, {:id => cluster.to_param, :cluster => valid_attributes}, valid_session
        response.should redirect_to(cluster)
      end
    end

    describe "with invalid params" do
      it "assigns the cluster as @cluster" do
        cluster = Cluster.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Cluster.any_instance.stub(:save).and_return(false)
        put :update, {:id => cluster.to_param, :cluster => { "name" => "invalid value" }}, valid_session
        assigns(:cluster).should eq(cluster)
      end

      it "re-renders the 'edit' template" do
        cluster = Cluster.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Cluster.any_instance.stub(:save).and_return(false)
        put :update, {:id => cluster.to_param, :cluster => { "name" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested cluster" do
      cluster = Cluster.create! valid_attributes
      expect {
        delete :destroy, {:id => cluster.to_param}, valid_session
      }.to change(Cluster, :count).by(-1)
    end

    it "redirects to the clusters list" do
      cluster = Cluster.create! valid_attributes
      delete :destroy, {:id => cluster.to_param}, valid_session
      response.should redirect_to(clusters_url)
    end
  end

end
