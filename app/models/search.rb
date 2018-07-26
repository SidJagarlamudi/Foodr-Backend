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

  # def search(term=DEFAULT_TERM, location=DEFAULT_LOCATION)
  #   url = "#{API_HOST}#{SEARCH_PATH}"
  #   params = {
  #     term: term,
  #     location: location,
  #     limit: SEARCH_LIMIT,
  #     categories: "Food"
  #   }

    def search(term=DEFAULT_TERM, coordinates={latitude: 40.7007739,
longitude: -73.9877738})
      url = "#{API_HOST}#{SEARCH_PATH}"
      params = {
        term: term,
        latitude: coordinates[:latitude],
        longitude: coordinates[:longitude],
        # location: location,
        limit: SEARCH_LIMIT,
        categories: "Food"
      }

    response = HTTP.auth("Bearer #{API_KEY}").get(url, params: params)
    # arr = response.parse["businesses"]
    new_response = JSON.parse(response)
    # binding.pry
    arr = new_response["businesses"]
    arr.each do |bus|
        do_delivery = bus["transactions"].include?("delivery")
        address = bus["location"]["display_address"].join(", ")
        coordinates = bus["coordinates"]
        search = self
        Business.create(business_id: bus["id"], name: bus["name"], image_url: bus["image_url"], is_closed: bus["is_closed"], url: bus["url"], reviews: bus["review_count"], rating: bus["rating"], do_delivery: do_delivery, price: bus["price"], address: address, phone: bus["display_phone"], latitude: bus["coordinates"]["latitude"], longitude: bus["coordinates"]["longitude"], search: search)
    end
  end

  # class Request
  #   class << self
  #     def where(resource_path, query = {}, options = {})
  #       response, status = get_json(resource_path, query)
  #       status == 200 ? response : errors(response)
  #     end
  #
  #     def get(id)
  #       response, status = get_json(id)
  #       status == 200 ? response : errors(response)
  #     end
  #
  #     def errors(response)
  #       error = { errors: { status: response["status"], message: response["message"] } }
  #       response.merge(error)
  #     end
  #
  #     def get_json(root_path, query = {})
  #       query_string = query.map{|k,v| "#{k}=#{v}"}.join("&")
  #       path = query.empty?? root_path : "#{root_path}?#{query_string}"
  #       response = api.get(path)
  #       [JSON.parse(response.body), response.status]
  #     end
  #
  #     def api
  #       Connection.api
  #     end
  #   end


  # end





end
