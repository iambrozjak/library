require "rails_helper"

RSpec.describe Devise::RegistrationsController, type: :request do
  let!(:user) { FactoryBot.create :user }
  let(:valid_attributes) { FactoryBot.attributes_for(:user) }
  let(:invalid_attributes) { FactoryBot.attributes_for(:user, :shot_password) }

  describe "GET devise/registrations#new" do
    it "is a successful registration" do
      get new_user_registration_path

      expect(response).to be_successful
    end
  end

  describe "GET devise/sessions#new" do
    it "is a successful login" do
      get new_user_session_path

      expect(response).to be_successful
    end
  end

  describe "POST devise/registrations#create" do
    context "with valid parameters" do
      it "registration is successful " do
        expect do
          post user_registration_path, params: { user: valid_attributes }
        end.to change(User, :count).by(1)

        expect(response).to be_redirect
        expect(flash[:notice]).to eq("Welcome! You have signed up successfully.")
      end
    end

    context "with invalid parameters" do
      it "registration is  not successful" do
        expect do
          post user_registration_path, params: { user: invalid_attributes }
        end.to change(User, :count).by(0)

        expect(response).to be_unprocessable
      end
    end
  end

  describe "DELETE devise/sessions#destroy" do
    it "delete user session" do
      delete destroy_user_session_path

      expect(response).to be_redirect
      expect(flash[:notice]).to eq("Signed out successfully.")
    end
  end
end
