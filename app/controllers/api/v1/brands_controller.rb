module Api
  module V1
    class BrandsController < ApplicationController
      def index
        @brands = Brand.all
        render json: @brands
      end

      def show
        @brand = Brand.find(params[:id])
        render json: @brand, include: :product_lines
      end

      def create
        @brand = Brand.new(brand_params)
        if @brand.save
          render json: @brand, status: :created
        else
          render json: @brand.errors, status: :unprocessable_entity
        end
      end

      private

      def brand_params
        params.require(:brand).permit(:name, :description)
      end
    end
  end
end