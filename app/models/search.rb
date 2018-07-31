# require 'faraday'
require "json"
require "http"


API_HOST = "https://api.yelp.com"
SEARCH_PATH = "/v3/businesses/search"
BUSINESS_PATH = "/v3/businesses/"  # trailing / because we append the business id to the path
API_KEY = ENV["YELP_API_KEY"]


# DEFAULT_BUSINESS_ID = "yelp-san-francisco"
DEFAULT_TERM = "dinner"
DEFAULT_LOCATION = "New York, NY"
SEARCH_LIMIT = 15


class Search < ApplicationRecord
  has_many :businesses
  belongs_to :user

  #   def search(term=DEFAULT_TERM, latitude=40.7007739, longitude=-73.9877738)
  #     url = "#{API_HOST}#{SEARCH_PATH}"
  #     params = {
  #       term: term,
  #       latitude: latitude,
  #       longitude: longitude,
  #       # location: location,
  #       limit: SEARCH_LIMIT,
  #       categories: "Food",
  #       radius: 1609
  #     }
  #
  #     # binding.pry
  #     # "hi"
  #
  #   response = HTTP.auth("Bearer #{API_KEY}").get(url, params: params)
  #   # arr = response.parse["businesses"]
  #   new_response = JSON.parse(response)
  #   # binding.pry
  #   # "hi"
  #   arr = new_response["businesses"]
  #   arr.each do |bus|
  #       do_delivery = bus["transactions"].include?("delivery")
  #       address = bus["location"]["display_address"].join(", ")
  #       coordinates = bus["coordinates"]
  #       search = self
  #       Business.create(business_id: bus["id"], name: bus["name"], image_url: bus["image_url"], is_closed: bus["is_closed"], url: bus["url"], reviews: bus["review_count"], rating: bus["rating"], do_delivery: do_delivery, price: bus["price"], address: address, phone: bus["display_phone"], latitude: bus["coordinates"]["latitude"], longitude: bus["coordinates"]["longitude"], search: search)
  #   end
  # end

  def search(term=DEFAULT_TERM, latitude=40.7007739, longitude=-73.9877738)
    url = "#{API_HOST}#{SEARCH_PATH}"
    params = {
      term: term,
      latitude: latitude,
      longitude: longitude,
      # location: location,
      limit: SEARCH_LIMIT,
      categories: "Food",
      radius: 1609
    }

    # binding.pry
    # "hi"

  response = HTTP.auth("Bearer #{API_KEY}").get(url, params: params)
  # arr = response.parse["businesses"]
  new_response = JSON.parse(response)
  # binding.pry
  # "hi"
  arr = new_response["businesses"]
  arr.each do |bus|
    distance = (bus["distance"] * 0.00062137119223733).round(2)
    next if distance > 10
    search = self
    name = bus["name"]
    image_url = bus["image_url"]
    is_closed = bus["is_closed"]
    url = bus["url"]
    reviews = bus["review_count"]
    rating = bus["rating"]
    price = bus["price"]
    phone = bus["display_phone"]

    do_delivery = bus["transactions"].include?("delivery")
    address = bus["location"]["display_address"].join(", ")
    latitude = bus["coordinates"]["latitude"]
    longitude = bus["coordinates"]["longitude"]
    categories = bus["categories"][0]["title"]
    distance = (bus["distance"] * 0.00062137119223733).round(2)
    # .map do |obj|
    #   obj.map do |key, value|
    #     return value if key == "title"
    #   end
    # end.join(", ")

      @business = Business.where(business_id: bus["id"]).first_or_create do |business|

        business.name = name
        business.image_url = image_url
        business.is_closed = is_closed
        business.url = url
        business.reviews = reviews
        business.rating = rating
        business.do_delivery = do_delivery
        business.price = price
        business.address = address
        business.phone = phone
        business.latitude = latitude
        business.longitude = longitude
        business.search = search
        business.categories = categories
        business.distance = distance
        end
        @business.is_closed = is_closed
        @business.search = search
        @business.distance = distance
        @business.save
    end


  end





end
