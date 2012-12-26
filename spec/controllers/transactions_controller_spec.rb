require 'spec_helper'

describe TransactionsController do
  before do
    @household = stub_model(Household, {:id => 1})
    Household.stub(:find) { @household }
    controller.class.skip_before_filter :authenticate_user!
  end

  def mock_user(stubs={})
    (@mock_user ||= mock_model(User).as_null_object).tap do |user|
      user.stub(stubs) unless stubs.empty?
    end
  end

  def mock_transaction(stubs={})
    (@mock_transaction ||= mock_model(Transaction).as_null_object).tap do |transaction|
      transaction.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all transactions as @transactions" do
      Transaction.stub(:for_household).with("1") { Transaction.stub(:all) { [mock_transaction] }; Transaction }
      get :index, {:household_id => "1"}
      assigns(:transactions).should eq([mock_transaction])
    end
  end

  describe "GET all_households" do
    it "should offer csv" do
      get :all_households, :format => :csv
      response.should be_success
    end
  end

  describe "GET show" do
    it "assigns the requested transaction as @transaction" do
      # setting up chained expectations (Transaction.for_household(1).find(37) => mock_transaction
      Transaction.stub(:for_household).with("1") { Transaction.stub(:find).with("37") { mock_transaction }; Transaction }
      get :show, {:household_id => "1", :id => "37"}
      assigns(:transaction).should be(mock_transaction)
    end
  end

  describe "GET edit" do
    it "assigns the requested transaction as @transaction" do
      # setting up chained expectations (Transaction.for_household(1).find(37) => mock_transaction
      Transaction.stub(:for_household).with("1") { Transaction.stub(:find).with("37") { mock_transaction }; Transaction }
      get :edit, {:id => "37", :household_id => "1"}
      assigns(:transaction).should be(mock_transaction)
    end
  end

  describe "Pagination" do
    before(:all) do
      31.times { FactoryGirl.create(:transaction) }
      visit '/transactions?page=2'
    end

    after(:all)  { Transaction.delete_all }

    it "should assign 1st transaction to page 2" do
      page.should have_content('Message 1')
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created transaction as @transaction" do
        Transaction.stub(:new).with({'these' => 'params'}) { mock_transaction(:save => true) }
        post :create,{:household_id => 1, :transaction => {'these' => 'params'}}
        assigns(:transaction).should be(mock_transaction)
      end

      it "redirects to the created transaction" do
        Transaction.stub(:new) { mock_transaction(:save => true) }
        post :create, {:household_id => 1, :transaction => {}}
        response.should redirect_to(household_url(1))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved transaction as @transaction" do
        Transaction.stub(:new).with({'these' => 'params'}) { mock_transaction(:save => false) }
        post :create, {:household_id => 1, :transaction => {'these' => 'params'}}
        assigns(:transaction).should be(mock_transaction)
      end

      it "re-renders the show household template" do
        Transaction.stub(:new).with({'these' => 'params'}) { mock_transaction(:save => false) }
        post :create, {:household_id => 1, :transaction => {'these' => 'params'}}
        response.should render_template('households/show')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested transaction" do
        Transaction.stub_chain(:for_household, :find) { mock_transaction }
        # how to do msg expectations with chained methods like this? instead of the above stub
        # Transaction.should_receive(:for_household).with("1").should_receive(:find).with("37") { mock_transaction }
        # Something like this? Is that even useful?
        # Transaction.should_receive(:for_household).with("1") { MockHouseholdScope }
        # MockHouseholdScope.should_receive(:find).with("37")) { mock_transaction }
        mock_transaction.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => "37", :household_id => 1, :transaction => {'these' => 'params'}}
      end

      it "assigns the requested transaction as @transaction" do
        Transaction.stub_chain(:for_household, :find) { mock_transaction(:update_attributes => true) }
        put :update, {:id => "1", :household_id => 1}
        assigns(:transaction).should be(mock_transaction)
      end

      it "redirects to the households transactions" do
        Transaction.stub_chain(:for_household, :find) { mock_transaction(:update_attributes => true, :household_id => 2) }
        put :update, {:id => "1", :household_id => 1}
        response.should redirect_to(household_transaction_url(:household_id => 1, :id => mock_transaction))
      end
    end

    describe "with invalid params" do
      it "assigns the transaction as @transaction" do
        Transaction.stub_chain(:for_household, :find) { mock_transaction(:update_attributes => false) }
        put :update, {:id => "1", :household_id => 1}
        assigns(:transaction).should be(mock_transaction)
      end

      it "re-renders the 'edit' template" do
        Transaction.stub_chain(:for_household, :find) { mock_transaction(:update_attributes => false) }
        put :update, {:id => "1", :household_id => 1}
        response.should render_template("edit")
      end
    end

  end
end
