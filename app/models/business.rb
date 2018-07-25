class Business < ApplicationRecord
  has_many :favorites
  has_many :users, through: :favorites
  belongs_to :search
end
