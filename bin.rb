require 'pry'
require 'tty-prompt'
require 'colorize'


class Bin
  attr_accessor :type, :size, :bin_level, :house, :collection_day

  # TODO: Look at bin volume and unit measurements
  # Add untis to the bin level
  def fill_bin
    # Clear terminal
    system 'clear'
    puts 'Update your bin\'s available space'
    puts ''
    # Get user input about the bin's new level and convert to an integer
    prompt = TTY::Prompt.new
    unit = prompt.ask('How many units would you like to add?', convert: :int)

    # If bin level will be less than 100, add unit if not dsplay error message
    if self.bin_level + unit <= 100
      self.bin_level = self.bin_level + unit
      # Display the amount of garbage entered into the bin, what bin type, and which house
      puts "You've added #{unit} units to your #{self.type.downcase} bin"
      sleep 1
    else
      puts 'Sorry! Looks like the bin is either full or you\'ve added too many units.'
      sleep 1
    end
    current_house = self
  end

  # TODO: Develop a method to automatically empty the bin after collection day
  # Empty bin
  def empty_bin
    self.bin_level = 0
  end

  def weekday_to_int
    case @collection_day
    when 'Monday' then 1
    when 'Tuesday' then 2
    when 'Wednesday' then 3
    when 'Thursday' then 4
    when 'Friday' then 5
    when 'Saturday' then 6
    when 'Sunday' then 0
    end
  end

    # displays upcoming collection days based on selected bin type
  def upcoming_collection_dates
    duration = 1 # One month
    start_date = Date.today # Collection start date
    end_date = Date.today >> duration
    collection_day = [weekday_to_int] # day of the week in 0-6. Sunday is day-of-week 0; Saturday is day-of-week 6.
    # Store upcoming collection days for a month from today
    upcoming_collections = (start_date..end_date).to_a.select {|k| collection_day.include?(k.wday)}
    puts upcoming_collections
    # Initiate Prompt object to provide back navigation to main menu
    prompt = TTY::Prompt.new(active_color: :bright_magenta)
    choices = %w(Yes)
    menu_choice = prompt.select('Back to main menu'.underline, choices, marker: '>')
    main_menu(self.house)
  end
end