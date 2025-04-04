module Api
  module V1
    class ItemsController < ApplicationController
      before_action :set_item, only: [ :show, :update, :destroy ]

      def index
        begin
          result = Paginator.paginate(
            Item.all,
            page: params[:page],
            per_page: params[:per_page]
          )
          serialized_data = ItemSerializer.serialize_collection(result[:data])
          render json: { data: serialized_data, meta: result[:meta] }
        rescue => e
          render json: { error: "Pagination error: #{e.message}" }, status: :unprocessable_entity
        end
      end

      def show
        render json: { data: ItemSerializer.new(@item).as_json }
      end

      def create
        @item = Item.new(item_params)
        if @item.save
          render json: @item, status: :created
        else
          render json: @item.errors, status: :unprocessable_entity
        end
      end

      def update
        if @item.update(item_params)
          render json: @item
        else
          render json: { errors: @item.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        @item.destroy
        head :no_content
      end

      private

      def set_item
        @item = Item.find(params[:id])
      end

      def item_params
        params.require(:item).permit(:shop_id, :model_id, characteristics: {}, prices: [ :amount, :currency ])
      end
    end
  end
end
