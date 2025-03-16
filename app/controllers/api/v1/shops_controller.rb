module Api
  module V1
    class ShopsController < ApplicationController
      def index
        @shops = Shop.all
        render json: @shops
      end

      def show
        @shop = Shop.find(params[:id])
        render json: @shop, include: :items # Include items in the response
      end

      def create
        @shop = Shop.new(shop_params)
        if @shop.save
          render json: @shop, status: :created
        else
          render json: @shop.errors, status: :unprocessable_entity
        end
      end

      private

      def shop_params
        params.require(:shop).permit(:name, :website_url)
      end
    end
  end
end