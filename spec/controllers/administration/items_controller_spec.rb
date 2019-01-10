# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Administration::ItemsController, type: :controller do
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns items in order to template" do
      item1 = FactoryBot.create(:item, name: "Rains Down")
      item2 = FactoryBot.create(:item, name: "In")
      item3 = FactoryBot.create(:item, name: "Africa")
      get :index
      expect(assigns(:items)).to match_array([item3, item2, item1])
    end
  end

  describe "PUT #update/:id" do
    subject(:update_item) { put :update, params: params }

    let(:item) { create(:item) }
    let(:params) { { id: item.id } }

    context 'without params' do
      it { expect(response).to have_http_status(:success) }
    end
  end
end
