class CouponsController < ApplicationController
  before_action :set_coupon, only: [:show, :update, :destroy]

  # GET /coupons
  def index
    @coupons = Coupon.all
    @coupons = @coupons.sort_by { |i| i[:id] }
    render json: CouponSerializer.new(@coupons)
  end

  # GET /coupons/1
  def show
    render json: @coupon
  end

  # POST /coupons
  def create
    @coupon = Coupon.new(coupon_params)
    if @coupon.save
      render json: @coupon, status: :created, location: @coupon
    else
      render json: @coupon.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /coupons/1
  def update
    if @coupon.update(coupon_params)
      render json: @coupon
    else
      render json: @coupon.errors, status: :unprocessable_entity
    end
  end

  # DELETE /coupons/1
  def destroy
    @coupon.destroy
  end

  def checkdiscount
    @coupon = Coupon.find_by(code: coupon_params[:code])
    if !@coupon.nil?
      render json: CouponSerializer.new(@coupon), status: 200
    else
      render json: { coupon: nil }, status: 500
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coupon
      @coupon = Coupon.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def coupon_params
      params.require(:coupon).permit(:discount, :code, :status)
    end
end
