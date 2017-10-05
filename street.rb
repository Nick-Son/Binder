# Required gems
require 'pry'
require 'colorize'
require 'terminal-table'

class Street
  attr_accessor :name, :suburb, :postcode, :state, :houses

  def initialize(name, suburb, postcode, state)
    @name = name
    @suburb = suburb
    @postcode = postcode
    @houses = []
  end

  def welcome_message
    "Welcome to #{self.name} binder".light_white.on_light_red
  end

  # a method to add houses to the @houses array
  def add_house_to_street(house)
    @houses << house
  end

  # a method to remove houses/residents from the street, therefore removing thier account
  def remove_house(house)
    @houses.delete(house)
  end

  # finds house based on email
  def find_house(email)
    found_house = nil
    @houses.each do |house|
      if house.email == email
        found_house = house
        break
      end
    end
    found_house
  end

  # Display all bins minus current_house in street in a table
  def available_bin_space(current_house)
    rows = [] 
    # loop through the houses array, displaying available space in both kinds of bins
    self.houses.each do |house|
      if house.contact_name != current_house.contact_name
        rows << [house.house_number, house.street.name, house.contact_name, house.general_bin_space, house.recycle_bin_space, house.green_bin_space] 
      end
    end  
  
    # Drawing and styling the table
    table = Terminal::Table.new :rows => rows
    table = Terminal::Table.new :title => ' Your neighbours available bin space '.light_white.on_light_red, :alignment => :center, 
      :headings => ['House number'.light_white, 'Street name'.light_white, 'Contact name'.light_white, 'General'.red, 'Recycle'.light_yellow, 'Green'.green], :rows => rows, :style => {:width => 100, :padding_left => 1, :border_x => "="}
    puts table
  end

  # display all recycle bin space on the street
  def available_recycle_space
    rows = []
 
    # puts "Current: #{house.contact_name}"
    current_house = house.contact_name
    # loop through to find all available recycling bin space
    self.houses.each do |house|
      if house.contact_name != current_house.contact_name
        rows << [house.house_number, house.street, house.contact_name, house.recycle_bin_space]
      end
    end
    # Drawing and styling the table
    table = Terminal::Table.new :rows => rows
    table = Terminal::Table.new :title => 'Available Recycling Bin Space'.magenta, :alignment => :center, 
      :headings => ['House number'.green, 'Street name'.green, 'Contact'.green, 'Recycle'.green], :rows => rows

    puts table
  end  

  # display all general bin space on the street
  def available_general_space
    rows = []
    # loop through to find all available general bin space
    self.houses.each do |house|
      rows << [house.house_number, house.street, house.contact_name, house.general_bin_space]
    end
    # Drawing and styling the table
    table = Terminal::Table.new :rows => rows
    table = Terminal::Table.new :title => 'Available General Bin Space'.magenta, :alignment => :center, 
      :headings => ['#'.green, 'Street Name'.green, 'Contact'.green, 'General'.green], :rows => rows
    puts table
  end  

  # display all green bin space on the street
  def available_green_space
    rows = []
    # loop through to find all available green bin space
    self.houses.each do |house|
      rows << [house.house_number, house.street, house.contact_name, house.green_bin_space]
    end
    # Drawing and styling the table
    table = Terminal::Table.new :rows => rows
    table = Terminal::Table.new :title => 'Available Green Bin Space'.magenta, :alignment => :center, 
      :headings => ['#'.green, 'Street Name'.green, 'Contact'.green, 'Green'.green], :rows => rows
    puts table
  end  

end