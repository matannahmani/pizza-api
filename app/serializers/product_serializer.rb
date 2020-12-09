class ProductSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :description, :price, :photo_url, :status
end
