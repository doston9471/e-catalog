module Api
  module V1
    class ItemsController < ApplicationController
      def index
        @items = Item.all
        render json: @items
      end

      def show
        @item = Item.find(params[:id])
        render json: @item
      end

      def create
        @item = Item.new(item_params)
        if @item.save
          render json: @item, status: :created
        else
          render json: @item.errors, status: :unprocessable_entity
        end
      end

      private

      def item_params
        params.require(:item).permit(:shop_id, :model_id, characteristics: {}, prices: [ :amount, :currency ])
      end
    end
  end
end