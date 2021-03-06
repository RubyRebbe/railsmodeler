class KlassesController < ApplicationController
  # GET /klasses
  # GET /klasses.json
  def index
    @klasses = Klass.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @klasses }
    end
  end

  # GET /klasses/1
  # GET /klasses/1.json
  def show
		@app = App.find( params[:app_id])
    @klass = Klass.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @klass }
    end
  end

  # GET /klasses/new
  # GET /klasses/new.json
  def new
		@app = App.find( params[:app_id])
    @klass = @app.klasses.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @klass }
    end
  end

  # GET /klasses/1/edit
  def edit
		@app = App.find( params[:app_id])
    @klass = Klass.find(params[:id])
  end

  # POST /klasses
  # POST /klasses.json
  def create
		@app = App.find( params[:app_id])
    @klass = @app.klasses.build( params[:klass])

    respond_to do |format|
      if @klass.save
        format.html { 
					redirect_to app_klass_path( @app, @klass, notice: 'Klass was successfully created.' )
				}
        format.json { render json: @klass, status: :created, location: @klass }
      else
        format.html { render action: "new" }
        format.json { render json: @klass.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /klasses/1
  # PUT /klasses/1.json
  def update
		@app = App.find( params[:app_id])
    @klass = Klass.find(params[:id])

    respond_to do |format|
      if @klass.update_attributes(params[:klass])
        format.html { 
					redirect_to app_klass_path( @app, @klass, notice: 'Klass was successfully updated.' )
				}
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @klass.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /klasses/1
  # DELETE /klasses/1.jsons
  def destroy
    @klass = Klass.find(params[:id])
		app = @klass.app
    @klass.destroy

    respond_to do |format|
      format.html { redirect_to app_path( app) }
      format.json { head :ok }
    end
  end
end
