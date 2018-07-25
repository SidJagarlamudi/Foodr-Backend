class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :favorites

  def favorites
    arr =
    self.object.businesses.map do |rest|
      {id: rest.id, name: rest.name, lat: rest.latitude, long: rest.longitude}
    end
  end
end
