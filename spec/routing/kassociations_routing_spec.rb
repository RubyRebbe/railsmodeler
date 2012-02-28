require "spec_helper"

describe KassociationsController do
  describe "routing" do

    it "routes to #index" do
      get("/kassociations").should route_to("kassociations#index")
    end

    it "routes to #new" do
      get("/kassociations/new").should route_to("kassociations#new")
    end

    it "routes to #show" do
      get("/kassociations/1").should route_to("kassociations#show", :id => "1")
    end

    it "routes to #edit" do
      get("/kassociations/1/edit").should route_to("kassociations#edit", :id => "1")
    end

    it "routes to #create" do
      post("/kassociations").should route_to("kassociations#create")
    end

    it "routes to #update" do
      put("/kassociations/1").should route_to("kassociations#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/kassociations/1").should route_to("kassociations#destroy", :id => "1")
    end

  end
end
