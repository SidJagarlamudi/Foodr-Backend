class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :favorites, :searches

  def favorites
    arr =
    self.object.spots.map do |rest|
      {id: rest.id, name: rest.name, lat: rest.latitude, long: rest.longitude}
    end
  end

  def searches
    self.object.searches
  end
end
