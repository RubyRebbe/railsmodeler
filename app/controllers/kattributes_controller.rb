class KattributesController < ApplicationController
  # GET /attributes
  # GET /attributes.json
  def index
    @attributes = Kattribute.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @attributes }
    end
  end

  # GET /attributes/1
  # GET /attributes/1.json
  def show
		@app = App.find( params[:app_id])
		@klass = Klass.find( params[:klass_id])
    @attribute = Kattribute.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @attribute }
    end
  end

  # GET /attributes/new
  # GET /attributes/new.json
  def new
		@app = App.find( params[:app_id])
		@klass = Klass.find( params[:klass_id])
 		@attribute = @klass.kattributes.build

		puts self.class.name + "#new"

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @attribute }
    end
  end

  # GET /attributes/1/edit
  def edit
		@app = App.find( params[:app_id])
    @klass = Klass.find(params[:klass_id])
    @attribute = Kattribute.find(params[:id])
  end

  # POST /attributes
  # POST /attributes.json
  def create
		@app = App.find( params[:app_id])
    @klass = Klass.find(params[:klass_id])
 		@attribute = @klass.kattributes.build( params[:kattribute])

    respond_to do |format|
      if @attribute.save
				format.html {
					redirect_to app_klass_path( @app, @klass,
						notice: 'Attribute was successfully created.' )
				}
        format.json { render json: @attribute, status: :created, location: @attribute }
      else
        format.html { render action: "new" }
        format.json { render json: @attribute.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /attributes/1
  # PUT /attributes/1.json
  def update
		@app = App.find( params[:app_id])
    @klass = Klass.find(params[:klass_id])
    @attribute = Kattribute.find(params[:id])

    respond_to do |format|
      if @attribute.update_attributes(params[:kattribute])
        format.html {
					redirect_to app_klass_path( @app, @klass,
						notice: 'Attribute was successfully updated.' )
				}
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @attribute.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attributes/1
  # DELETE /attributes/1.json
  def destroy
    @attribute = Kattribute.find(params[:id])
		@klass = @attribute.klass
		@app = @klass.app

    @attribute.destroy

    respond_to do |format|
      format.html { redirect_to app_klass_path( @app, @klass)  }
      format.json { head :ok }
    end
  end
end
