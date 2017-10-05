# Required gems
require 'pry'
require 'tty-prompt'
require 'catpix'
require 'colorize'
require 'terminal-table'

# Required files
require_relative 'menu.rb' # Menu.rb contains all menus in binder application
require_relative 'bin.rb' # Class Bin
require_relative 'house.rb' # Class House
require_relative 'street.rb' # Class Street
require_relative 'contact.rb' # contact methods

# Displays a terminal representation of the binder logo.
def print_banner
  Catpix::print_image "binder_logo.jpg",
    :center_x => true,
    :center_y => true,
    :resolution => 'low'
end

# Creating a new street object that will be the basis of the project.
new_street = Street.new('Victoria Street', 'Carlton', 'Victoria', 3000)

# Creating a new house object
new_house_1 =  {contact_name: 'Matt', phone: '+6141122334', email: 'matt@email.com', password: 'password', house_number: 1, street: new_street}
new_house_1 = House.new(new_house_1)

# Creating general waste, recycling and green waste bins and assigning them to the first house (new_house_1)
new_waste_bin_1 = Bin.new
new_waste_bin_1.type = 'General waste'
new_waste_bin_1.size = 'Large'
new_waste_bin_1.bin_level = 25
new_waste_bin_1.collection_day = 'Monday'
new_waste_bin_1.house = new_house_1
new_house_1.add_bin(new_waste_bin_1)
new_recycling_bin_1 = Bin.new
new_recycling_bin_1.type = 'Recycling'
new_recycling_bin_1.size = 'Small'
new_recycling_bin_1.bin_level = 50
new_recycling_bin_1.collection_day = 'Monday'
new_recycling_bin_1.house = new_house_1
new_house_1.add_bin(new_recycling_bin_1)
new_green_bin_1 = Bin.new
new_green_bin_1.type = 'Green waste'
new_green_bin_1.size = 'Medium'
new_green_bin_1.bin_level = 10
new_green_bin_1.collection_day = 'Thursday'
new_green_bin_1.house = new_house_1
new_house_1.add_bin(new_green_bin_1)

# Creating a new house object
new_house_2 =  {contact_name: 'Brett', phone: '+6141122334', email: 'brett@email.com', password: 'password', house_number: 2, street: new_street}
new_house_2 = House.new(new_house_2)

# Creating general waste, recycling and green waste bins and assigning them to the second house (new_house_2)
new_waste_bin_2 = Bin.new
new_waste_bin_2.type = 'General waste'
new_waste_bin_2.size = 'Large'
new_waste_bin_2.bin_level = 90
new_waste_bin_2.collection_day = 'Monday'
new_waste_bin_2.house = new_house_2
new_house_2.add_bin(new_waste_bin_2)
new_recycling_bin_2 = Bin.new
new_recycling_bin_2.type = 'Recycling'
new_recycling_bin_2.size = 'Small'
new_recycling_bin_2.bin_level = 100
new_recycling_bin_2.collection_day = 'Monday'
new_recycling_bin_2.house = new_house_2
new_house_2.add_bin(new_recycling_bin_2)
new_green_bin_2 = Bin.new
new_green_bin_2.type = 'Green waste'
new_green_bin_2.size = 'Medium'
new_green_bin_2.bin_level = 80
new_green_bin_2.collection_day = 'Thursday'
new_green_bin_2.house = new_house_2
new_house_2.add_bin(new_green_bin_2)

# Creating a new house object
new_house_3 =  {contact_name: 'Nick', phone: '+61411223344', email: 'nick@email.com', password: 'password', house_number: 3, street: new_street}
new_house_3 = House.new(new_house_3)

# Creating general waste, recycling and green waste bins and assigning them to the third house (new_house_3)
new_waste_bin_3 = Bin.new
new_waste_bin_3.type = 'General waste'
new_waste_bin_3.size = 'Large'
new_waste_bin_3.bin_level = 10
new_waste_bin_3.collection_day = 'Monday'
new_waste_bin_3.house = new_house_3
new_house_3.add_bin(new_waste_bin_3)
new_recycling_bin_3 = Bin.new
new_recycling_bin_3.type = 'Recycling'
new_recycling_bin_3.size = 'Small'
new_recycling_bin_3.bin_level = 85
new_recycling_bin_3.collection_day = 'Monday'
new_recycling_bin_3.house = new_house_3
new_house_3.add_bin(new_recycling_bin_3)
new_green_bin_3 = Bin.new
new_green_bin_3.type = 'Green waste'
new_green_bin_3.size = 'Medium'
new_green_bin_3.bin_level = 40
new_green_bin_3.collection_day = 'Thursday'
new_green_bin_3.house = new_house_3
new_house_3.add_bin(new_green_bin_3)

# Adding the three houses to the street object
new_street.add_house_to_street(new_house_1)
new_street.add_house_to_street(new_house_2)
new_street.add_house_to_street(new_house_3)

# Running the app, passing the street object as an argument 
welcome_menu(new_street)