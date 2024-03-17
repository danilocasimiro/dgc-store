# frozen_string_literal: true

require 'rails_helper'

module Api
  module V1
    RSpec.describe 'ProductTypesController', type: :request do
      let(:token) { generate_fake_jwt(user: { company_id: company.id }) }
      let(:company) { create(:company) }

      describe 'GET #index' do
        context 'when user is logged in' do
          before do
            create_list(:product_type, 2, company:)
            create_list(:product_type, 3, company: build(:company))

            get "/api/v1/companies/#{company.id}/product_types",
                headers: { Authorization: "Bearer #{token}" }
          end

          it 'returns a success response' do
            expect(response).to have_http_status(:success)
          end

          it 'returns JSON response with paginated models' do
            expect(response).to be_successful
            expect(JSON.parse(response.body).size).to eq(2)
          end
        end

        context 'when user is not logger in' do
          before do
            get "/api/v1/companies/#{company.id}/product_types"
          end

          it 'returns a unauthorized response' do
            expect(response).to have_http_status(:unauthorized)
          end
        end
      end

      describe 'POST #create' do
        context 'when user is logged in' do
          let(:product_type_params) { attributes_for(:product_type) }

          before do
            post "/api/v1/companies/#{company.id}/product_types",
                 params: { product_type: product_type_params },
                 headers: { Authorization: "Bearer #{token}" }
          end

          it 'creates a new product_type' do
            expect(response).to have_http_status(:ok)
            product_type = ProductType.last
            expect(product_type.name).to eq(product_type_params[:name])
            expect(product_type.company_id).to eq(company.id)
          end
        end

        context 'when user is not logger in' do
          before do
            post "/api/v1/companies/#{company.id}/product_types"
          end

          it 'returns a unauthorized response' do
            expect(response).to have_http_status(:unauthorized)
          end
        end
      end

      describe 'PUT #update' do
        let(:product_type) { create(:product_type, company:) }

        context 'when user is logged in' do
          let(:product_type_params) { { name: 'new_name' } }
          let(:product_type_update_url) do
            "/api/v1/companies/#{company.id}/product_types/#{product_type.id}"
          end

          before do
            put product_type_update_url,
                params: { product_type: product_type_params },
                headers: { Authorization: "Bearer #{token}" }
          end

          it 'updates a new product_type' do
            expect(response).to have_http_status(:ok)
            expect(response.body).to include(product_type_params[:name])
            product_type.reload
            expect(product_type.name).to eq('new_name')
          end

          context 'when user is not logger in' do
            before do
              put product_type_update_url
            end

            it 'returns a unauthorized response' do
              expect(response).to have_http_status(:unauthorized)
            end
          end
        end
      end

      describe 'DELETE #destroy' do
        let(:product_type) { create(:product_type, company:) }
        let(:product_type_delete_url) do
          "/api/v1/companies/#{company.id}/product_types/#{product_type.id}"
        end

        context 'when user is logged in' do
          before do
            delete product_type_delete_url,
                   headers: { Authorization: "Bearer #{token}" }
          end

          it 'delete a product_type' do
            expect(response).to have_http_status(:ok)
            expect do
              ProductType.find(product_type.id)
            end.to raise_error(ActiveRecord::RecordNotFound)
          end
        end

        context 'when user is not logger in' do
          before do
            delete product_type_delete_url
          end

          it 'returns a unauthorized response' do
            expect(response).to have_http_status(:unauthorized)
          end
        end
      end
    end
  end
end
