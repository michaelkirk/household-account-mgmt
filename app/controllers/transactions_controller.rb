class TransactionsController < ApplicationController
  # GET /households/:id/transactions
  # GET /households/:id/transactions.xml
  def index
    @household = Household.find(params[:household_id])
    @transactions = Transaction.for_household(params[:household_id])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @transactions }
    end
  end

  # GET /households/:id/transactions/1
  # GET /households/:id/transactions/1.xml
  def show
    @household = Household.find(params[:household_id])
    @transaction = Transaction.for_household(params[:household_id]).find(params[:id])
  
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @transaction }
    end
  end

  # GET /households/:id/transactions/new
  # GET /households/:id/transactions/new.xml
  def new
    @household = Household.find(params[:household_id])
    @transaction = Transaction.for_household(params[:household_id]).new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @transaction }
    end
  end

  # GET /households/:id/transactions/1/edit
  def edit
    @household = Household.find(params[:household_id])
    @transaction = Transaction.for_household(params[:household_id]).find(params[:id])
  end

  # POST /households/:id/transactions
  # POST /households/:id/transactions.xml
  def create
    @household = Household.find(params[:household_id])
    @transaction = Transaction.for_household(params[:household_id]).new(params[:transaction])

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to([@household, @transaction], :notice => 'Household transaction was successfully created.') }
        format.xml  { render :xml => @transaction, :status => :created, :location => @transaction }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @transaction.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /households/:id/transactions/1
  # PUT /households/:id/transactions/1.xml
  def update
    @household = Household.find(params[:household_id])
    @transaction = Transaction.for_household(params[:household_id]).find(params[:id])

    respond_to do |format|
      if @transaction.update_attributes(params[:transaction])
        format.html { redirect_to([@household, @transaction], :notice => 'Household transaction was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @transaction.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /households/:id/transactions/1
  # DELETE /households/:id/transactions/1.xml
  def destroy
    raise Exception.new("deleting transaction's is not allowed")
    @household = Household.find(params[:household_id])
    @transaction = Transaction.for_household(params[:household_id]).find(params[:id])
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to(household_transactions_url(@houshold)) }
      format.xml  { head :ok }
    end
  end
end
