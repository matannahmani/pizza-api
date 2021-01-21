class ShopsController < ApplicationController
  before_action :authenticate_user!, except: :show

  # GET /shops/1
  def show
    shop = Shop.first
    render json: { open: shop.open, delivery: shop.delivery, takeaway: shop.takeaway }
  end

  def switchshop
    Shop.first.update(open: !Shop.first.open)
    render json: Shop.first
  end

  def switchdelivery
    Shop.first.update(delivery: !Shop.first.delivery)
    render json: Shop.first
  end

  def switchtakeaway
    Shop.first.update(takeaway: !Shop.first.takeaway)
    render json: Shop.first
  end

end
