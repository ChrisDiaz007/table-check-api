class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :first_name, :last_name, :phone_number, :role, :admin, :email, :created_at

  attribute :created_date do |user|
    user.created_at && user.created_at.strftime('%m/%d/%Y')
  end
end
