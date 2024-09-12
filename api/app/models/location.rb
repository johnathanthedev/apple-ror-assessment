class Location < ApplicationRecord
  has_many :forecasts

  validates :lat, :lon, presence: true
end
