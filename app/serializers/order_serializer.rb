class OrderSerializer
  include JSONAPI::Serializer
  attributes :id, :address, :phone, :name, :takeaway, :price,:done, :status, :shipped, :created_at, :productlist
end
