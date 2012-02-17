require "spec_helper"

describe KlassesController do
  describe "routing" do

    it "routes to #index" do
      get("/klasses").should route_to("klasses#index")
    end

    it "routes to #new" do
      get("/klasses/new").should route_to("klasses#new")
    end

    it "routes to #show" do
      get("/klasses/1").should route_to("klasses#show", :id => "1")
    end

    it "routes to #edit" do
      get("/klasses/1/edit").should route_to("klasses#edit", :id => "1")
    end

    it "routes to #create" do
      post("/klasses").should route_to("klasses#create")
    end

    it "routes to #update" do
      put("/klasses/1").should route_to("klasses#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/klasses/1").should route_to("klasses#destroy", :id => "1")
    end

  end
end
