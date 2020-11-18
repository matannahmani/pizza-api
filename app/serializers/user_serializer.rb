class UserSerializer
  include JSONAPI::Serializer
  attributes :name, :phone, :address, :email
end
