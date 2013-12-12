require 'httparty'
require 'json'

var_client_id = 'YAY-- THINGS GO HERE'
var_api_key   = 'ALSO HERE'

#response = HTTParty.get("https://api.digitalocean.com/droplets/?client_id=#{var_client_id}&api_key=#{var_api_key}")

#puts response["droplets"]
#puts response["status"]

response = HTTParty.get("https://api.digitalocean.com/images/?client_id=#{var_client_id}&api_key=#{var_api_key}")

hash_of_all_images = response["images"]

public_images = []

hash_of_all_images.each do |image|
  if image["public"]
    public_images.push(image["id"])
  end
end

puts public_images
