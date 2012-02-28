class KassociationsController < ApplicationController
  # GET /kassociations
  # GET /kassociations.json
  def index
    @kassociations = Kassociation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @kassociations }
    end
  end

  # GET /kassociations/1
  # GET /kassociations/1.json
  def show
		@app = App.find( params[:app_id])
    @kassociation = Kassociation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @kassociation }
    end
  end

  # GET /kassociations/new
  # GET /kassociations/new.json
  def new
		@app = App.find( params[:app_id])
    @kassociation = @app.kassociations.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @kassociation }
    end
  end

  # GET /kassociations/1/edit
  def edit
		@app = App.find( params[:app_id])
    @kassociation = Kassociation.find(params[:id])
  end

  # POST /kassociations
  # POST /kassociations.json
  def create
		@app = App.find( params[:app_id])
    @kassociation = @app.kassociations.build( params[:kassociation])

    respond_to do |format|
      if @kassociation.save
        format.html {
						redirect_to app_kassociation_path( @app, @kassociation, 
							notice: 'Kassociation was successfully created.' )
				}
        format.json { render json: @kassociation, status: :created, location: @kassociation }
      else
        format.html { render action: "new" }
        format.json { render json: @kassociation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /kassociations/1
  # PUT /kassociations/1.json
  def update
		@app = App.find( params[:app_id])
    @kassociation = Kassociation.find(params[:id])

    respond_to do |format|
      if @kassociation.update_attributes(params[:kassociation])
 				format.html { 
					redirect_to app_path( @app, notice: 'Kassociation was successfully updated.' )
				}
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @kassociation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kassociations/1
  # DELETE /kassociations/1.json
  def destroy
    @kassociation = Kassociation.find(params[:id])
		app = @kassociation.app
    @kassociation.destroy

    respond_to do |format|
 			format.html { redirect_to app_path( app) }
      format.json { head :ok }
    end
  end
end
