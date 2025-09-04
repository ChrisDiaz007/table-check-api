class TableSerializer
  include JSONAPI::Serializer
  attributes :number, :seats

  attribute :user_id do |table|
    table.restaurant.user_id
  end

end
