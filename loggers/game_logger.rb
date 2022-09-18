module GameLogger

  def self.prompt_food_name
    puts "Enter a name for a food:".blue
  end

  def self.prompt_food_energy(food_name)
    puts "Enter an energy level for the #{food_name}:".blue
  end

  def self.food_added(food)
    puts "#{food.name} with an energy level of #{food.energy} has been added!".green
    self.bar
  end

  def self.food_not_created(e)
    puts "Food was not able to be created:".red
    p e
    puts "If you wish to return to the main menu, input 'exit'".red
  end

  def self.return_to_menu
    puts "Returning you to main menu...".blue
    self.bar
  end

  def self.actions
    puts "Available commands are:\n\nstatus\nwelcome\nactivities\nfoods\nadd food\nexit\n".green
    puts "You can always return to this menu with the 'menu' or 'home' command.".green
    puts self.bar
  end

  def self.list_foods(foods)
    puts "Available foods:".green
    foods.each {|food| puts "Name: #{food.name}, Energy: #{food.energy}".blue }
    puts "Please select food below by typing the name of it".green
  end

  def self.list_activities(available, unavailable)
    puts "Please select an activity below by inputting the name of it:\n".blue

    if available.length > 0
      puts "Available:\n"
      available.each {|activity| puts "#{activity.name} (Energy: #{activity.energy})".green}
    end

    if unavailable.length > 0
      puts "Unavailable:\n" 
      unavailable.each {|activity| puts "#{activity.name} | (Energy: #{activity.energy})".red} 
    end
  end

  def self.bar
    puts "~~~~~~~~~~~~~~~~~~~~"
  end

  def self.exiting
    puts "Shutting down the game. Thanks for playing!".green
  end

end