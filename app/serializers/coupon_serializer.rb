class CouponSerializer
  include JSONAPI::Serializer
  attributes :id, :discount, :code, :status
end
