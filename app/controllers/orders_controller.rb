class OrdersController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :item_id_set, only: [:index, :create]
  before_action :move_to_index, only: [:index]

  def index
    if @item.order.present?
      redirect_to root_path
    else
      @order_purchaser = OrderPurchaser.new
    end
  end

  def create
    @order_purchaser = OrderPurchaser.new(order_purchaser_params)
    if @order_purchaser.valid?
      pay_item
      @order_purchaser.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_purchaser_params
    params.require(:order_purchaser).permit(:post_code, :prefecture_id, :city, :house_number, :building, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_purchaser_params[:token],
      currency: 'jpy'
    )
  end

  def item_id_set
    @item = Item.find(params[:item_id])
  end

  def move_to_index
    redirect_to root_path if current_user.id == @item.user.id
  end
end
