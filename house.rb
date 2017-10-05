# Required gems
require 'pry'
require 'terminal-table'

class House
  attr_accessor :contact_name, :email, :password, :phone, :house_number, :street, :bins, :total_bin_space

  def initialize(house = {})
    @contact_name = house[:contact_name]
    @house_number = house[:house_number]
    @street = house[:street]
    @email = house[:email]
    @password = house[:password]
    @phone = house[:phone]
    @bins = [] # an array that hold the bins belonging to the house
  end

  # Add a bin to the bin array
  def add_bin(bin)
    @bins << bin
    bin.house = self
  end

  # Checks if the password entered matches the password of the selected email account
  def check_password(house, password)
    if house.password == password
      house = house
    else
      return nil
    end
  end

  # TODO: Develop a method to only update some data
  def update_house(house)
    @contact_name = house[:contact_name]
    @phone = house[:phone]
    @email = house[:email]
    @password = house[:password]
  end

  # to calculate the amount of combined space in the general waste bins of selected house.
  def general_bin_space
    general_bin_space = 0
    @bins.each do |bin|
      if bin.type == 'General'
        general_bin_space = bin.bin_level.to_i + general_bin_space
      end  
    end
    general_bin_space
  end
  
  # to calculate the amount of combined space in the recylce waste bins of selected house.
  def recycle_bin_space
    recycle_bin_space = 0
    @bins.each do |bin|
      if bin.type == 'Recycle'
        recycle_bin_space = bin.bin_level.to_i + recycle_bin_space
      end  
    end
    recycle_bin_space
  end

    # to calculate the amount of combined space in the green waste bins of selected house.
  def green_bin_space
    green_bin_space = 0
    @bins.each do |bin|
      if bin.type == 'Green'
        green_bin_space = bin.bin_level.to_i + green_bin_space
      end  
    end
    green_bin_space
  end

  # displays collection days of each bin belonging to the house
  def collection_day
    puts "#{self.street.name} binder".light_white.on_light_red
    puts ''
    puts "#{self.contact_name}, the next collection days for your house are:"
    puts ''
    @bins.each do |bin|
      puts "#{bin.type}: #{bin.collection_day}"
    end
  end
  
  # Displays contact details of the selected house
  def contact_details
    puts "Contact name: #{self.contact_name}"
    puts "Phone number: #{self.phone}"
    puts "Email: #{self.email}"
  end

  # show a table with status of the household's bins
  def bin_status
    rows = []

    # loop through to find all available bin space
    self.bins.each do |bin|
      rows << [bin.type, "#{bin.bin_level}%"]
    end
    # Drawing and styling the table
    table = Terminal::Table.new :rows => rows
    table = Terminal::Table.new :title => ' Your available bin space '.light_white.on_light_red, :headings => ['Bin type'.light_white, 'How much used'.light_white], :rows => rows, :style => {:width => 100, :padding_left => 1, :border_x => "="}

    puts table
  end 
end