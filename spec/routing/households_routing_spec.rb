require "spec_helper"

describe HouseholdsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/households" }.should route_to(:controller => "households", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/households/new" }.should route_to(:controller => "households", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/households/1" }.should route_to(:controller => "households", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/households/1/edit" }.should route_to(:controller => "households", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/households" }.should route_to(:controller => "households", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/households/1" }.should route_to(:controller => "households", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/households/1" }.should route_to(:controller => "households", :action => "destroy", :id => "1")
    end

  end
end
