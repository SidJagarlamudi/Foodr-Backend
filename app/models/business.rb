class Business < ApplicationRecord
  has_many :favorites, :foreign_key => "spot_id"
  has_many :users, through: :favorites
  belongs_to :search
end
