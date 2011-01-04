class HouseholdsController < ApplicationController
  # GET /households
  # GET /households.xml
  def index
    @households = Household.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @households }
    end
  end

  # GET /households/1
  # GET /households/1.xml
  def show
    @household = Household.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @household }
    end
  end

  # GET /households/new
  # GET /households/new.xml
  def new
    @household = Household.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @household }
    end
  end

  # GET /households/1/edit
  def edit
    @household = Household.find(params[:id])
  end

  # POST /households
  # POST /households.xml
  def create
    @household = Household.new(params[:household])

    respond_to do |format|
      if @household.save
        format.html { redirect_to(@household, :notice => 'Household was successfully created.') }
        format.xml  { render :xml => @household, :status => :created, :location => @household }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @household.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /households/1
  # PUT /households/1.xml
  def update
    @household = Household.find(params[:id])

    respond_to do |format|
      if @household.update_attributes(params[:household])
        format.html { redirect_to(@household, :notice => 'Household was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @household.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /households/1
  # DELETE /households/1.xml
  def destroy
    @household = Household.find(params[:id])
    @household.destroy

    respond_to do |format|
      format.html { redirect_to(households_url) }
      format.xml  { head :ok }
    end
  end
end
