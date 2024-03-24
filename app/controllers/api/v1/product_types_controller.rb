# frozen_string_literal: true

module Api
  module V1
    class ProductTypesController < ApplicationController
      include Concerns::CompanyContext

      before_action :set_resource, only: %i[show update destroy]

      def index
        @models = model_class.with_company_id(current_company_id)

        render json: paginate(@models)
      end

      def show
        render json: @model.as_json(include: include_associations)
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
          model_class.with_company_id(current_company_id).find(params[:id])
      end

      def permitted_params
        params.require(:product_type).permit(:name)
              .merge(company_id: current_company_id)
      end
    end
  end
end
