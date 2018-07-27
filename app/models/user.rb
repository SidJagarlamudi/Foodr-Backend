class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: true
  has_many :favorites
  has_many :searches
  has_many :spots, through: :favorites
  has_many :businesses, through: :searches

  def favorite_spots
    self.spots.map do |rest|
      favorite = Favorite.find_by(spot_id: rest.id)
      { id: rest.id, name: rest.name, favorite_id: favorite.id, latitude: rest.latitude, longitude: rest.longitude }
    end
  end

end
