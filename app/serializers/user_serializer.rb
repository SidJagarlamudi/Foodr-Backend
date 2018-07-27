class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :favorites, :searches

  def favorites
    arr =
    self.object.spots.map do |rest|
      favorite = Favorite.find_by(spot_id: rest.id)
      {id: rest.id, favorite_id: favorite.id, name: rest.name, lat: rest.latitude, long: rest.longitude}
    end
  end

  def searches
    self.object.searches
  end
end
