class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :business
  validates_uniqueness_of :user_id, :scope => :business_id
end
