class UserSerializer
  include JSONAPI::Serializer
  attributes :email, :name, :adminlevel
end
