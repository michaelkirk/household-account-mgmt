require "spec_helper"

describe TransactionsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/households/1/transactions" }.should route_to(:controller => "transactions", :household_id => "1", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/households/1/transactions/new" }.should route_to(:controller => "transactions", :household_id => "1", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/households/1/transactions/1" }.should route_to(:controller => "transactions", :household_id => "1", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/households/1/transactions/1/edit" }.should route_to(:controller => "transactions", :household_id => "1", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/households/1/transactions" }.should route_to(:controller => "transactions", :household_id => "1", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/households/1/transactions/1" }.should route_to(:controller => "transactions", :household_id => "1", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/households/1/transactions/1" }.should route_to(:controller => "transactions", :household_id => "1", :action => "destroy", :id => "1")
    end

  end
end
