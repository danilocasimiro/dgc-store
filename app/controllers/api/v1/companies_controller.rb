# frozen_string_literal: true

module Api
  module V1
    class CompaniesController < ApplicationController
      include Concerns::UserContext

      before_action :set_resource, only: %i[update destroy]

      def index
        @models = model_class.all

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
          model_class.find(params[:id])
      end

      def permitted_params
        params.require(:company).permit(:owner_id)
      end
    end
  end
end
