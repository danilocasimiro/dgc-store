# frozen_string_literal: true

module Api
  module V1
    class ProductsController < ApplicationController
      include Concerns::CompanyContext

      before_action :set_resource, only: %i[update destroy]

      def index
        @models = model_class.with_company_id(company_id_param)

        render json: paginate(@models)
      end

      def create
        @model = model_class.create!(permitted_params)
        render json: @model
      end

      def update
        @model.update!(permitted_params)

        render json: @model
      end

      def destroy
        @model.destroy!
        head :ok
      end

      private

      def set_resource
        @model =
          model_class.with_company_id(params[:company_id]).find(params[:id])
      end

      def company_id_param
        params.require(:company_id)
      end

      def permitted_params
        params.require(:product)
              .permit(:name, :product_type_id, :price, :stock, :status)
      end
    end
  end
end
