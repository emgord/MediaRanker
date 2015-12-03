require 'rails_helper'

include Rails.application.routes.url_helpers

RSpec.shared_examples "a medium controller" do

  describe "GET 'index'" do
    it "is successful" do
      get :index
      expect(response.status).to eq 200
    end
  end

  describe "GET 'new'" do
    it "renders new view" do
      get :new
      expect(subject).to render_template :new
    end
  end

  describe "POST 'create'" do

    it "redirects to show page" do
      post :create, good_params
      expect(subject).to redirect_to polymorphic_path(assigns(media_type))
    end
    it "renders new template on error" do
      post :create, bad_params
      expect(subject).to render_template :new
    end
  end

  describe "GET 'show'" do
    it "renders the show view" do
      get :show, id: test_medium.id
      expect(subject).to render_template :show
    end
  end

  describe "GET 'edit'" do
    it "renders edit view" do
      get :edit, id: test_medium.id
      expect(subject).to render_template :edit
    end
  end

  describe "PATCH 'update'" do

    it "redirects to show page" do
      patch :update, good_update_params
      expect(subject).to redirect_to polymorphic_path(assigns(media_type))
    end
    it "renders edit template on error" do
      patch :update, bad_update_params
      expect(subject).to render_template :edit
    end
  end

  describe "DELETE 'destroy'" do
    it "redirects to the index view" do
      delete :destroy, id: test_medium.id
      expect(subject).to redirect_to polymorphic_path(media_type_plural)
    end
  end

  describe "PATCH 'upvote'" do

    let(:upvote_params) do {
        id: test_medium.id
      }
    end

    it "redirects to show page" do
      patch :upvote, upvote_params
      expect(subject).to redirect_to polymorphic_path(test_medium)
    end

    it "increases the rank value by 1" do
      patch :upvote, upvote_params
      test_medium.reload
      expect(test_medium.rank).to eq 1
    end
  end
end
