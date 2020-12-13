class ProductSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :description, :price, :jprice, :photo_url, :status, :size
end
