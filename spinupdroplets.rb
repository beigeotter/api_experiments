require 'digital_ocean'
include Comparable

dc = DigitalOcean::API.new :client_id => 'CLIENT ID HERE',
                           :api_key   => 'API KEY HERE'
                          
                           
# Gets list of DigitalOcean active droplet information
do_list = dc.images.list.images
public_images = Array.new

#Getting all public image ids, avoiding my own! :)
do_list.each do |hash|
  if hash.public?
    public_images.push(hash.id)
  end
  end

puts public_images

# Getting available droplet size IDs under 4GB

droplet_sizes = dc.sizes.list.sizes
#droplet_sizes = droplet_sizes 
puts droplet_sizes

sizes = Array.new
droplet_sizes.each do |hash|
  if hash.memory < 8192
    sizes.push(hash.id)
  else
    #puts "pineapple"
    #puts hash.name
  end
end

puts sizes

# Getting available region ids 

region_list = dc.regions.list.regions
regions = Array.new
region_list.each do |region|
  regions.push(region.id)
end

# The 3 arrays have now been made
# We have a public_images, sizes, and regions

puts public_images
use_these_images = [303619, 308287]

#puts use_these_images
puts sizes
puts regions

# Create hash of all possible combinations of droplets
combinations = public_images.product(sizes, regions)
puts combinations.size

 use_these_images.each do |image|
   sizes.each do |size|
     regions.each do |region|
      name = "#{image}-#{size}-#{region}-d"

puts name, size, image, region
#       dc.droplets.create       :name      => name,
#                                :size_id   => size,
#                                :image_id  => image,
#                                :region_id => region
end
end
end


                         

