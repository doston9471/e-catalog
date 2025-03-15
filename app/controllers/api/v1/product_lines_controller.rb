module Api
  module V1
    class ProductLinesController < ApplicationController
      def index
        @product_lines = ProductLine.all
        render json: @product_lines
      end

      def show
        @product_line = ProductLine.find(params[:id])
        render json: @product_line, include: :models
      end

      def create
        @product_line = ProductLine.new(product_line_params)
        if @product_line.save
          render json: @product_line, status: :created
        else
          render json: @product_line.errors, status: :unprocessable_entity
        end
      end

      private

      def product_line_params
        params.require(:product_line).permit(:name, :category, :brand_id)
      end
    end
  end
end