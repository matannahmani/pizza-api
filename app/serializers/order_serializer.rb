class OrderSerializer
  include JSONAPI::Serializer
  attributes :id, :address, :phone, :name, :takeaway, :price,:url,:done, :status, :shipped, :created_at, :productlist
end
