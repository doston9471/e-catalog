module Api
  module V1
    class BrandsController < ApplicationController
      before_action :set_brand, only: [ :show, :update, :destroy ]

      def index
        @brands = Brand.all
        render json: @brands
      end

      def show
        render json: @brand, include: :product_lines
      end

      def create
        @brand = Brand.new(brand_params)
        if @brand.save
          render json: @brand, status: :created
        else
          render json: { errors: @brand.errors }, status: :unprocessable_entity
        end
      end

      def update
        if @brand.update(brand_params)
          render json: @brand
        else
          render json: { errors: @brand.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        @brand.destroy
        head :no_content
      end

      private

      def set_brand
        @brand = Brand.find(params[:id])
      end

      def brand_params
        params.require(:brand).permit(:name, :description)
      end
    end
  end
end
