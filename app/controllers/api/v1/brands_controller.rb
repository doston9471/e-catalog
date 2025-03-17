module Api
  module V1
    class BrandsController < ApplicationController
      before_action :set_brand, only: [ :show, :update, :destroy ]

      def index
        begin
          result = Paginator.paginate(
            Brand.all,
            page: params[:page],
            per_page: params[:per_page]
          )
          serialized_data = BrandSerializer.serialize_collection(result[:data])
          render json: { data: serialized_data, meta: result[:meta] }
        rescue => e
          render json: { error: "Pagination error: #{e.message}" }, status: :unprocessable_entity
        end
      end

      def show
        render json: { data: BrandSerializer.new(@brand).as_json }
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
