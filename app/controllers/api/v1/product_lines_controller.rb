module Api
  module V1
    class ProductLinesController < ApplicationController
      before_action :set_product_line, only: [ :show, :update, :destroy ]

      def index
        begin
          result = Paginator.paginate(
            ProductLine.all,
            page: params[:page],
            per_page: params[:per_page]
          )
          serialized_data = ProductLineSerializer.serialize_collection(result[:data])
          render json: { data: serialized_data, meta: result[:meta] }
        rescue => e
          render json: { error: "Pagination error: #{e.message}" }, status: :unprocessable_entity
        end
      end

      def show
        render json: { data: ProductLineSerializer.new(@product_line).as_json }
      end

      def create
        @product_line = ProductLine.new(product_line_params)
        if @product_line.save
          render json: @product_line, status: :created
        else
          render json: @product_line.errors, status: :unprocessable_entity
        end
      end

      def update
        if @product_line.update(product_line_params)
          render json: @product_line
        else
          render json: { errors: @product_line.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        @product_line.destroy
        head :no_content
      end

      private

      def set_product_line
        @product_line = ProductLine.find(params[:id])
      end

      def product_line_params
        params.require(:product_line).permit(:name, :category, :brand_id)
      end
    end
  end
end
