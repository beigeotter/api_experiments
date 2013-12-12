require 'httparty'
require 'json'
require 'pry'

var_client_id = ENV['DO_CLIENT_ID']
var_api_key   = ENV['DO_API_KEY']

#response = HTTParty.get("https://api.digitalocean.com/droplets/?client_id=#{var_client_id}&api_key=#{var_api_key}")

#puts response["droplets"]
#puts response["status"]

response = HTTParty.get("https://api.digitalocean.com/images/?client_id=#{var_client_id}&api_key=#{var_api_key}")

hash_of_all_images = response["images"]

images = []

hash_of_all_images.each do |image|
  if image["public"]
    images.push(image["id"])
  end
end

puts images

sizes_response = HTTParty.get("https://api.digitalocean.com/sizes/?client_id=#{var_client_id}&api_key=#{var_api_key}")

puts sizes_response["status"]

droplet_sizes= sizes_response["sizes"]


puts droplet_sizes

sizes = []

droplet_sizes.each do |size|
  if size["memory"] < 8192
    sizes.push(size["id"])
  end
end

puts sizes


regions_response = HTTParty.get("https://api.digitalocean.com/regions/?client_id=#{var_client_id}&api_key=#{var_api_key}")

puts regions_response["status"]

region_ids = regions_response["regions"]

regions = []


region_ids.each do |region|
    regions.push(region["id"])
end


puts regions

use_these_images = [308287]

combinations = images.product(sizes, regions)
puts combinations.size




use_these_images.each do |image|
   sizes.each do |size|
     regions.each do |region|
      name = "#{image}-#{size}-#{region}-d"
	droplet_creation_response = HTTParty.get("https://api.digitalocean.com/droplets/new?client_id=#{var_client_id}&api_key=#{var_api_key}&name=#{name}&size_id=#{size}&image_id=#{image}&region_id=#{region}")

	droplet_status = droplet_creation_response["status"]
	if droplet_status == "ERROR"
		puts droplet_creation_response["message"]
	else
		puts "Success" 
     	end
	end
   end
end





