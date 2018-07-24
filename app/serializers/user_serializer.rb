class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :favorites

  def favorites
    arr =
    self.object.businesses.map do |rest|
      {id: rest.id, name: rest.name}
    end
  end
end
