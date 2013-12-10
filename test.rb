puts "hello"
require 'httparty'
require 'json'

var_client_id = 'YAY-- THINGS GO HERE'
var_api_key   = 'ALSO HERE'
                          
 

#response = HTTParty.get("https://api.digitalocean.com/droplets/?client_id=#{var_client_id}&api_key=#{var_api_key}")

#puts response["droplets"]
#puts response["status"]




response = HTTParty.get("https://api.digitalocean.com/images/?client_id=#{var_client_id}&api_key=#{var_api_key}")

puts response["images"]

hash_of_all_images = response["images"]

puts hash_of_all_images

public_images = Array.new


puts "can I reach this part?"

hash_of_all_images.each do |hash, public|
  if [hash]["public"] == true
    public_images.push(hash.id)
  end
  end


exit
            

