# app/controllers/items_controller.rb
class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show]

  def index
    @items = Item.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: '出品が完了しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  private

  # ストロングパラメータ
  def item_params
    params.require(:item).permit(
      :name, :description, :category_id, :condition_id, :shipping_fee_status_id,
      :prefecture_id, :shipping_day_id, :price, :image
    ).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
