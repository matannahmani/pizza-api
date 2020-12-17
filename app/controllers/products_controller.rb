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
    new_params = product_params.except(:photodata)
    @product = Product.new(new_params)
    if @product.save
      image_upload
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def checkcart
    if params[:products].nil?
      render json: { data: nil }
    else
      result = []
      params[:products].each do |p|
        pd = Product.find_by(name: p.split('=>')[0]) #checks if product exists
        next if pd.nil?

        if pd.size.include?(p.split('=>')[1]) && pd.status
          pd = pd.attributes.merge(photourl: pd.photo_url,choosensize: p.split('=>')[1],amount: p.split('=>')[2])
          result << pd.except('updated_at', 'created_at')
        end
      end
      result.sort_by! { |i| i[:id] }
      render json: result, status: :ok
    end
  end

  # PATCH/PUT /products/1
  def update
    new_params = product_params.except(:photodata)
    if @product.update(new_params)
      @product.photo.destroy.purge if @product.photo.attached? && !product_params[:photodata].nil?
      image_upload if !product_params[:photodata].nil?
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
      params.require(:product).permit(:name, :price, :jprice, :description, :photodata, :status, size: [])
      params.permit(products: [])
    end

    def image_upload
      decoded_data = Base64.decode64(product_params[:photodata].split(',')[1])
      @product.photo.attach(
        io: StringIO.new(decoded_data),
        content_type: 'image/jpeg',
        filename: "#{@product.name}#{@product.id}"
      )
    end
end
