class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :move_to_index

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    
    if @order_address.valid?
      begin
      pay_item
      @order_address.save
      redirect_to root_path
    rescue Payjp::Error => e
       @order_address.errors.add(:base, "Card information is invalid.")
      render :index, status: :unprocessable_entity
    end
      else
        gon.public_key = ENV['PAYJP_PUBLIC_KEY']
        render :index, status: :unprocessable_entity
  end
  end


  private

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number, :token).merge(
      user_id: current_user.id, item_id: params[:item_id]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_index
    return redirect_to new_user_session_path unless user_signed_in?
  
  if @item.user_id == current_user.id || @item.order.present?
    redirect_to root_path
  end
end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
