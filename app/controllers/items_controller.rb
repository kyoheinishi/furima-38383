class ItemsController < ApplicationController
  before_action :authenticate_user!


  def index
  end

  def new
    @item = Item.new
  end


  private

  def item_params
    params.require(:item).permit(:item_name, :image, :caption, :category_id, :condition_id, :shipping_cost_id, :prefecture_id, :shipping_day_id, :price).merge(user_id: current_user.id)
  end

end
