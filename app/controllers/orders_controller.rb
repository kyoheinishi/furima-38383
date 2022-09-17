class OrdersController < ApplicationController
  before_action :authenticate_user!, only: :index


  def index
    @item = Item.find(params[:item_id])
    @order_purchaser = OrderPurchaser.new
  end

  def create
    @order_purchaser = OrderPurchaser.new(order_purchaser_params)
    @item = Item.find(params[:item_id])
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
    params.require(:order_purchaser).permit(:post_code, :prefecture_id, :city, :house_number, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_purchaser_params[:token],
      currency: 'jpy'
    )
  end

  

end
