module Api
  module V1
    class ModelsController < ApplicationController
      def index
        @models = Model.all
        render json: @models
      end

      def show
        @model = Model.find(params[:id])
        render json: @model
      end

      def create
        @model = Model.new(model_params)
        if @model.save
          render json: @model, status: :created
        else
          render json: @model.errors, status: :unprocessable_entity
        end
      end

      private

      def model_params
        params.require(:model).permit(:name, :product_line_id, specifications: {})
      end
    end
  end
end
