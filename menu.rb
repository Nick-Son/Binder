# Required gems
require 'pry'
require 'tty-prompt'
require 'colorize'

# Display initial/welcome menu when app starts
def welcome_menu(street)
  street = street
  current_house = nil

  # Loop through menu options
  loop do
    system 'clear'  # Clear screen
    
    # Call .print_banner to display image in terminal
    print_banner
    puts ''
    puts street.welcome_message
    puts '' 

    # Create new Prompt instance to ask user for input
    prompt = TTY::Prompt.new(active_color: :bright_magenta)
    # Display options and store input in menu_choice variable
    menu_choice = prompt.select('What would you like to do?'.underline, marker: '>') do |menu|
      # Allow user to use arrows or enter numbers to select an option
      menu.enum '.'
      # Main menu options
      menu.choice 'Sign in', 1
      menu.choice 'Sign up', 2
      menu.choice 'Help/FAQ', 3
      menu.choice 'Exit', 4
    end

    case menu_choice
    when 1 # Sign in
      # Call .sign_in_form and store returned value from method in current_house variable
      current_house = sign_in_form(street)
      # Display success message and call .main_method
      if current_house
        puts "You've successfully signed in to #{street.name} binder!"
        sleep 2 # Pause to allow user to read message
        # Call main menu and pass in house object for current user
        main_menu(current_house)
      end
    when 2 # Sign up
      # Call .sign_in_form and store returned value from method in current_house variable
      current_house = sign_up_form(street)
      # Display success message and call .main_method
      if current_house
        puts "You've successfully signed up to #{street.name} binder!"
        sleep 2 # Pause to allow user to read message
        # Call main menu and pass in house object for current user
        main_menu(current_house)
      end
    when 3 # Help/FAQ
      # TODO: Develop help and FAQ data
      puts 'Help and FAQ'
      puts ''
      puts 'Sorry, this feature is not yet available' 
      sleep 3 # Pause before returning to back to the welcome menu options
    when 4
      puts "Thank you for using #{street.name} binder! Hope to see you again soon!"
      sleep 2 # Pause to allow user to read message
      break # Exit loop and take user back to welcome menu
    end  
  end  
end

# Display sign in form to get and check username login details
def sign_in_form(street)
  system 'clear'  # Clear screen

  # Set variables to nil to be accessed in method
  house = nil
  current_house = nil

  puts 'Sign in to binder'.underline
  puts ''
  
  # Loop until the user has entered an email associated with a house
  # TODO: Develop option for user to break loop if no account
  until house
    # Create new Prompt instance to ask user for email
    prompt = TTY::Prompt.new(active_color: :bright_magenta)
    email = prompt.ask('Email:') do |email|
      email.required true
    end
    # Find house by email and store returned house object in variable
    house = street.find_house(email)
    # Display error message if email is not found
    puts "We haven't found an account with #{email}" if house.nil?
  end
  
  # Loop until the user has entered the password that matches the email previously entered
  # TODO: Develop option for user to break loop
  until current_house
    # Create new Prompt instance to ask user for password
    prompt = TTY::Prompt.new(active_color: :bright_magenta)
    # Password is masked when entered
    password = prompt.mask('Password:') do |password|
      password.required true
    end
    # Check that password matches the stored password and if so, store returned house object in variable
    current_house = house.check_password(house, password)
    # Display error message if password does not match
    puts "Sorry! Password incorrect - try again!" if current_house.nil?
  end
  # Return variable with current house object
  current_house
end

def sign_up_form(street)
  system 'clear' # Clear screen

  # Display screen heading
  puts "Sign up to #{street.name} binder".underline
  puts ''

  # Create a new instance of Prompt
  prompt = TTY::Prompt.new(active_color: :bright_magenta)
  
  # Get and store input from user in a hash
  # TODO: Get input about house's bins - currently hardcoded below
  house = prompt.collect do
    key(:contact_name).ask('Name:', required: true)
    key(:phone).ask('Contact number:', required: true)
    key(:email).ask('Email:', required: true)
    key(:password).mask('Password:', required: true)
    key(:house_number).ask('House number:', required: true)
  end

  # Add street to house hash
  house[:street] = street

  # Create a new instance of House
  new_house = House.new(house)

  # TODO: Replace with prompt menu
  new_waste_bin = Bin.new
  new_waste_bin.type = 'General waste'
  new_waste_bin.size = 'Large'
  new_waste_bin.bin_level = 0
  new_waste_bin.collection_day = 'Monday'
  new_waste_bin.house = new_house
  new_house.add_bin(new_waste_bin)
  new_recyclable_bin = Bin.new
  new_recyclable_bin.type = 'Recyclables'
  new_recyclable_bin.size = 'Small'
  new_recyclable_bin.bin_level = 0
  new_recyclable_bin.collection_day = 'Monday'
  new_recyclable_bin.house = new_house
  new_house.add_bin(new_recyclable_bin)
  new_green_bin = Bin.new
  new_green_bin.type = 'Green waste'
  new_green_bin.size = 'Medium'
  new_green_bin.bin_level = 0
  new_green_bin.collection_day = 'Thursday'
  new_green_bin.house = new_house
  new_house.add_bin(new_green_bin)

  street.add_house_to_street(new_house)

  # Return variable with current house object
  new_house
end

# Display .main_menu after a user has signed up or signed in successfully
def main_menu(house)
  current_house = house
  street = current_house.street

  # Loop through menu options
  loop do
    system 'clear' # Clear screen
    puts ''
    # Display next collection day for each bin type
    current_house.collection_day
    puts ''
    # Display the available space in the current house's bins
    current_house.bin_status
    puts ''
    # Display space in other resident's bins
    street.available_bin_space(current_house)
    puts ''

    # Create a new instance of Prompt
    prompt = TTY::Prompt.new(active_color: :bright_magenta)
    # Get and store input from current house
    selection = prompt.select('Main menu'.underline, marker: '>') do |menu|
      # Allow user to use arrows or enter numbers to select an option
      menu.enum '.'
      # Main menu options
      menu.choice 'Contact neighbour', 1
      menu.choice 'Update my bin levels', 2
      menu.choice 'Update my contact details', 3
      menu.choice 'View upcoming collection days', 4
      menu.choice 'Remove my house from binder', 5
      menu.choice 'Sign out', 6
    end

    case selection
    when 1 # Contact a neighbour to ask to add rubbish to bin
      contact_menu(current_house)
      break
    when 2 # Update bin levels for currnt house
      update_bin_menu(current_house)
    when 3 # Update house contact details
      update_house(current_house)
    when 4 # Display upcoming collection days
      # TODO: Build calendar to display upcoming collection days
      collection_day_menu(current_house)
      break
    when 5 # Remove current house object from app
      street.remove_house(house)
      puts 'Your house has been removed from binder.'
      sleep 2
      break
    when 6 # Sign out
      puts 'You\'ve successfully signed out'
      sleep 2
      break
    end
  end
end

# TODO: Develop option to contact via email through terminal
# Display menu options for contacting other residents in the street
def contact_menu(house)
  system 'clear' # Clear screen
  current_house = house
  street = house.street
  puts 'Contact your neighbour'.underline
  puts ''

  # Calls method and passes the logged in user's house and display all available space in street in a table
  street.available_bin_space(current_house)
  puts ''
  # Empty array for menu options
  choices = %w()
  # Loop through houses to add all houses to choices array except current house
  street.houses.each do |house|
    if house.contact_name != current_house.contact_name
      choices << house.contact_name
    end
  end

  # TODO: Work on option to go back to main menu
  # Add option to go back to main menu
  # choices << 'Back to main menu'

  # Create a new instance of Prompt to get and store input 
  prompt = TTY::Prompt.new(active_color: :bright_magenta)
  # Display list of other houses for current user to select to contact
  menu_choice = prompt.select('Who would you like to contact?', choices)

  # Loop through each house to find the house that matches the menu_choice variable 
  street.houses.each do |house|
    if menu_choice == house.contact_name
      house.contact_details
      sms_recipient = {house.phone => house.contact_name}
      contact_by_sms(sms_recipient)
      break
    # else
    #   main_menu(current_house)
    #   break
    end
  end

  # Create a new instance of Prompt to provide option to go back to main menu
  prompt = TTY::Prompt.new(active_color: :bright_magenta)
  choices = %w(Yes)
  menu_choice = prompt.select('Back to main menu'.underline, choices, marker: '>')
  # Return back to main menu
  main_menu(current_house)
end

# Update contact details for a house
def update_house(house)
  system 'clear' # Clear screen
  current_house = house

  puts 'Update your details'.underline
  puts ''

  # Create a new instance of Prompt
  prompt = TTY::Prompt.new(active_color: :bright_magenta)
  # Get and store input from user into a hash
  update_details = prompt.collect do
    key(:contact_name).ask('Name:', required: true)
    key(:phone).ask('Contact number:', required: true)
    key(:email).ask('Email:', required: true)
    key(:password).mask('Password:', required: true)
  end
  current_house.update_house(update_details)
end

# a menu where the user can fill their selected bin type
def update_bin_menu(house)
  system 'clear'
  current_house = house

  puts 'Update your bin\'s available space'
  puts ''

  # Display signed in user's bin levels in a table
  house.bin_status

  # Create a new instance of Prompt
  prompt = TTY::Prompt.new(active_color: :bright_magenta)
  # Display menu with each bin type listed
  choice = prompt.select('Which bin would you like to update?'.underline, marker: '>') do |menu|
    menu.choice 'General waste'
    menu.choice 'Recycling'
    menu.choice 'Green waste'
    menu.choice 'Back to main menu'
  end
  choice = choice.downcase

  # Call fill bin method to update bin level for the selected bin
  selected_bin = nil
  house.bins.each do |bin|
    if bin.type.downcase == choice
      selected_bin = bin
      selected_bin.fill_bin
    end
  end
end

# Display menu to view the upcoming collection days for the selected bin type
def collection_day_menu(current_house)
  prompt = TTY::Prompt.new(active_color: :bright_magenta)
  choice = prompt.select('Which bin would you like to update?'.underline, marker: '>') do |menu|
    menu.choice 'General waste'
    menu.choice 'Recycling'
    menu.choice 'Green waste'
    menu.choice 'Back to main menu'
  end

  selected_bin = nil
  # Loop through the current house's bin to find a match with the choice from the menu
  current_house.bins.each do |bin|
    if bin.type == choice
      selected_bin = bin
      break
    end
  end
  selected_bin.upcoming_collection_dates
end