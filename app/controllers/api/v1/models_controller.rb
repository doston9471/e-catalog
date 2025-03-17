module Api
  module V1
    class ModelsController < ApplicationController
      before_action :set_model, only: [ :show, :update, :destroy ]

      def index
        begin
          result = Paginator.paginate(
            Model.all,
            page: params[:page],
            per_page: params[:per_page]
          )
          serialized_data = ModelSerializer.serialize_collection(result[:data])
          render json: { data: serialized_data, meta: result[:meta] }
        rescue => e
          render json: { error: "Pagination error: #{e.message}" }, status: :unprocessable_entity
        end
      end

      def show
        render json: { data: ModelSerializer.new(@model).as_json }
      end

      def create
        @model = Model.new(model_params)
        if @model.save
          render json: @model, status: :created
        else
          render json: { errors: @model.errors }, status: :unprocessable_entity
        end
      end

      def update
        if @model.update(model_params)
          render json: @model
        else
          render json: { errors: @model.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        @model.destroy
        head :no_content
      end

      private

      def set_model
        @model = Model.find(params[:id])
      end

      def model_params
        params.require(:model).permit(:name, :description, :product_line_id, specifications: {})
      end
    end
  end
end
