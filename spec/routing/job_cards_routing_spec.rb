require "rails_helper"

RSpec.describe JobCardsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/job_cards").to route_to("job_cards#index")
    end

    it "routes to #new" do
      expect(get: "/job_cards/new").to route_to("job_cards#new")
    end

    it "routes to #show" do
      expect(get: "/job_cards/1").to route_to("job_cards#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/job_cards/1/edit").to route_to("job_cards#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/job_cards").to route_to("job_cards#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/job_cards/1").to route_to("job_cards#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/job_cards/1").to route_to("job_cards#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/job_cards/1").to route_to("job_cards#destroy", id: "1")
    end
  end
end
