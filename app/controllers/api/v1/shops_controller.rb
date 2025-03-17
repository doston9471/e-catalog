module Api
  module V1
    class ShopsController < ApplicationController
      before_action :set_shop, only: [ :show, :update, :destroy ]

      def index
        begin
          result = Paginator.paginate(
            Shop.all,
            page: params[:page],
            per_page: params[:per_page]
          )
          render json: result
        rescue => e
          render json: { error: "Pagination error: #{e.message}" }, status: :unprocessable_entity
        end
      end

      def show
        render json: @shop, include: :items
      end

      def create
        @shop = Shop.new(shop_params)
        if @shop.save
          render json: @shop, status: :created
        else
          render json: { errors: @shop.errors }, status: :unprocessable_entity
        end
      end

      def update
        if @shop.update(shop_params)
          render json: @shop
        else
          render json: { errors: @shop.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        @shop.destroy
        head :no_content
      end

      private

      def set_shop
        @shop = Shop.find(params[:id])
      end

      def shop_params
        params.require(:shop).permit(:name, :website_url)
      end
    end
  end
end
