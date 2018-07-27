# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "pry"

User.destroy_all
Business.destroy_all
Favorite.destroy_all


tom = User.create(email: "tom@gmail.com", password: "1234")
sarah = User.create(email: "sarah@gmail.com", password: "1234")

# search1 = Search.create(term: "sushi", user: tom)

# result = search1.search("sushi", 40.7007739, -73.9877738)

# binding.pry
# "hi"

# Favorite.create(user: tom, spot: Business.find(1))


# require "json"
# require "http"
#
# API_HOST = "https://api.yelp.com"
# SEARCH_PATH = "/v3/businesses/search"
# BUSINESS_PATH = "/v3/businesses/"  # trailing / because we append the business id to the path
# API_KEY = ENV["YELP_API_KEY"]
#
#
# DEFAULT_BUSINESS_ID = "yelp-san-francisco"
# DEFAULT_TERM = "dinner"
# DEFAULT_LOCATION = "New York, NY"
# SEARCH_LIMIT = 10

# # Returns a parsed json object of the request
# def search(term=DEFAULT_TERM, location=DEFAULT_LOCATION)
#   url = "#{API_HOST}#{SEARCH_PATH}"
#   params = {
#     term: term,
#     location: location,
#     limit: SEARCH_LIMIT
#   }
#
#   response = HTTP.auth("Bearer #{API_KEY}").get(url, params: params)
#   # arr = response.parse["businesses"]
#   new_response = JSON.parse(response)
#   # binding.pry
#   arr = new_response["businesses"]
#     arr.each do |bus|
#       do_delivery = bus["transactions"].include?("delivery")
#       address = bus["location"]["display_address"].join(", ")
#       coordinates = bus["coordinates"]
#       Business.create(business_id: bus["id"], name: bus["name"], image_url: bus["image_url"], is_closed: bus["is_closed"], url: bus["url"], reviews: bus["review_count"], rating: bus["rating"], do_delivery: do_delivery, price: bus["price"], address: address, phone: bus["display_phone"], latitude: bus["coordinates"]["latitude"], longitude: bus["coordinates"]["longitude"])
#   end
# end
#
# super_search = search("sushi", "New York")
# # binding.pry
#
#
# # Returns a parsed json object of the request
# def business(business_id)
#   url = "#{API_HOST}#{BUSINESS_PATH}#{business_id}"
#
#   response = HTTP.auth("Bearer #{API_KEY}").get(url)
#   response.parse
# end
