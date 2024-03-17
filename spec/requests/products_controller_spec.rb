# frozen_string_literal: true

require 'rails_helper'

module Api
  module V1
    RSpec.describe 'ProductsController', type: :request do
      let(:token) { generate_fake_jwt(user: { company_id: company.id }) }
      let(:company) { create(:company) }

      describe 'GET #index' do
        context 'when user is logged in' do
          let(:product_type) { create(:product_type, company:) }

          before do
            create_list(:product, 3)
            create_list(:product, 5, product_type:)

            get "/api/v1/companies/#{company.id}/products",
                headers: { Authorization: "Bearer #{token}" }
          end

          it 'returns a success response' do
            expect(response).to have_http_status(:success)
          end

          it 'returns JSON response with paginated models' do
            expect(response).to be_successful
            expect(JSON.parse(response.body).size).to eq(5)
          end
        end

        context 'when user is not logger in' do
          before do
            get "/api/v1/companies/#{company.id}/products"
          end

          it 'returns a unauthorized response' do
            expect(response).to have_http_status(:unauthorized)
          end
        end
      end

      describe 'POST #create' do
        context 'when user is logged in' do
          let(:product_type) { create(:product_type) }

          let(:product_params) do
            attributes_for(:product).merge(product_type_id: product_type.id)
          end

          before do
            post "/api/v1/companies/#{company.id}/products",
                 params: { product: product_params },
                 headers: { Authorization: "Bearer #{token}" }
          end

          it 'creates a new product' do
            expect(response).to have_http_status(:ok)
            product = Product.last
            expect(product.name).to eq(product_params[:name])
          end
        end

        context 'when user is not logger in' do
          before do
            post "/api/v1/companies/#{company.id}/products"
          end

          it 'returns a unauthorized response' do
            expect(response).to have_http_status(:unauthorized)
          end
        end
      end

      describe 'PUT #update' do
        let(:product_type) { create(:product_type, company:) }
        let(:product) { create(:product, product_type:) }

        context 'when user is logged in' do
          let(:product_params) { { name: 'new_name' } }

          before do
            put "/api/v1/companies/#{company.id}/products/#{product.id}",
                params: { product: product_params },
                headers: { Authorization: "Bearer #{token}" }
          end

          it 'updates a new product' do
            expect(response).to have_http_status(:ok)
            expect(response.body).to include(product_params[:name])
            product.reload
            expect(product.name).to eq('new_name')
          end
        end

        context 'when user is not logger in' do
          before do
            put "/api/v1/companies/#{company.id}/products/#{product.id}"
          end

          it 'returns a unauthorized response' do
            expect(response).to have_http_status(:unauthorized)
          end
        end
      end

      describe 'DELETE #destroy' do
        let(:product_type) { create(:product_type, company:) }
        let(:product) { create(:product, product_type:) }
        let(:product_delete_url) do
          "/api/v1/companies/#{company.id}/products/#{product.id}"
        end

        context 'when user is logged in' do
          before do
            delete product_delete_url,
                   headers: { Authorization: "Bearer #{token}" }
          end

          it 'delete a product_type' do
            expect(response).to have_http_status(:ok)
            expect do
              Product.find(product.id)
            end.to raise_error(ActiveRecord::RecordNotFound)
          end
        end

        context 'when user is not logger in' do
          before do
            delete product_delete_url
          end

          it 'returns a unauthorized response' do
            expect(response).to have_http_status(:unauthorized)
          end
        end
      end
    end
  end
end
