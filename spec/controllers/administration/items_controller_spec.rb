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

  describe "PUT update" do
    let(:item) { FactoryBot.create(:item) }
    let(:item_with_discount) { FactoryBot.create(:item, original_price: 20) }
    let(:item_without_discount) { FactoryBot.create(:item_without_discount, original_price: 10) }

    context "with valid data" do
      let(:discount) { { discount_percentage: 50 } }

      it "redirects to administration items" do
        put :update, params: { id: item, item: discount }
        expect(response).to redirect_to(administration_items_path)
      end

      it "updates item with discount in the database" do
        put :update, params: { id: item_with_discount, item: discount }
        item_with_discount.reload
        expect(item_with_discount.price).to eq(10)
      end

      it "updates item without discount in the database" do
        put :update, params: { id: item_without_discount, item: discount }
        item_without_discount.reload
        expect(item_without_discount.price).to eq(5)
      end

      it "updates attribute has_discount to true" do
        put :update, params: { id: item_without_discount, item: discount }
        item_without_discount.reload
        expect(item_without_discount.has_discount).to eq true
      end
    end

    context "with invalid data" do
      let(:invalid_discount) { { discount_percentage: -1 } }

      it "renders administration page" do
        put :update, params: { id: item_with_discount, item: invalid_discount }
        expect(response).to redirect_to(administration_items_path)
      end

      it "doesn't update item in the database" do
        put :update, params: { id: item_with_discount, item: invalid_discount }
        item_with_discount.reload
        expect(item_with_discount.discount_percentage).not_to eq(-1)
      end
    end
  end
end
