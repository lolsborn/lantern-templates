class UserSerializer
  include JSONAPI::Serializer

  attributes :id, :email, :first_name, :last_name, :created_at, :updated_at

  attribute :full_name do |user|
    user.full_name
  end

  attribute :display_name do |user|
    user.display_name
  end
end