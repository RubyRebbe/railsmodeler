class AppsController < ApplicationController
  # GET /apps
  # GET /apps.json

	before_filter :get_app, :except => :index

  def index
    @apps = App.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @apps }
    end
  end

  # GET /apps/1
  # GET /apps/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @app }
    end
  end

  # GET /apps/new
  # GET /apps/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @app }
    end
  end

  # GET /apps/1/edit
  def edit
  end

  # POST /apps
  # POST /apps.json
  def create
    respond_to do |format|
      if @app.save
        format.html { redirect_to @app, notice: 'App was successfully created.' }
        format.json { render json: @app, status: :created, location: @app }
      else
        format.html { render action: "new" }
        format.json { render json: @app.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /apps/1
  # PUT /apps/1.json
  def update
    respond_to do |format|
      if @app.update_attributes(params[:app])
        format.html { redirect_to @app, notice: 'App was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @app.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apps/1
  # DELETE /apps/1.json
  def destroy
    @app.destroy

    respond_to do |format|
      format.html { redirect_to apps_url }
      format.json { head :ok }
    end
  end

	# summarizes the code generation for this app
	def summarize
	end

	def download
		respond_to do |format|
			format.rb { 
				render :text => @app.to_code.reduce( "") { |m,s| m + "\n" + s } , :mime_type => :rb 
			}
		end
	end

protected
	def get_app
		@app = params[:id].blank? ? App.new : App.find(params[:id])		
	end
end
