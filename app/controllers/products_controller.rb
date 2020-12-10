class ProductsController < ApplicationController
  require 'open-uri'
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /products
  def index
    @products = Product.all
    @products = @products.sort_by { |i| i[:id] }
    render json: ProductSerializer.new(@products)
  end

  # GET /products/1
  def show
    render json: @product
  end

  # POST /products
  def create
    new_params = product_params.except(:data)
    @product = Product.new(new_params)
    if @product.save
      image_upload
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    new_params = product_params.except(:data)
    if @product.update(new_params)
      @product.photo.destroy.purge if @product.photo.attached? && !product_params[:data].nil?
      image_upload if !product_params[:data].nil?
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:name, :price, :description, :data, :status, :size => [])
    end

    def image_upload
      decoded_data = Base64.decode64(product_params[:data].split(',')[1])
      @product.photo.attach(
        io: StringIO.new(decoded_data),
        content_type: 'image/jpeg',
        filename: "#{@product.name}#{@product.id}"
      )
    end
end
