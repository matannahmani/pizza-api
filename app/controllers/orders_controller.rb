class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy]
  before_action :authenticate_user!, except: :create
  # GET /orders
  def index
    @orders = Order.all

    render json: @orders
  end

  # GET /orders/1
  def show
    render json: @order
  end

  # POST /orders
  def create
    # binding.pry
    new_params = order_params.except(:order_products, :coupon)
    coupon = Coupon.find_by(code: order_params[:coupon])
    @order = Order.new(new_params)
    @order.coupon = coupon
    if @order.save
      order_params[:order_products].each do |item|
        begin
          OrderProduct.create(product: Product.find(item[:id]), size: item[:size], order: @order, amount: item[:amount])
        rescue
          @order.destroy
          return render json: { data: 'error', status: 500 }
        end
      end
      @order.setprice
      render json: @order, status: :created, location: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(order_params)
      render json: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /orders/1
  def destroy
    @order.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def order_params
      params.require(:order).permit(:address, :phone, :name, :takeaway, :user_id, :price, :coupon, :order_products => [:id,:amount,:size])
    end
end
