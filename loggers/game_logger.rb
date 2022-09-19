module GameLogger

  # Pet

  def self.prompt_pet_name
    puts "Enter a name for the new pet:".blue
  end

  def self.pet_not_created(error)
    puts "The pet was not able to be created:".red
    p error
    puts "If you wish to return to the main menu, input 'exit'".red
  end

  def self.prompt_pet_species
    puts "Enter the species of the pet (e.g. dog, cat, horse, chicken):".blue
  end  

  def self.current_pet_set(pet)
    puts "#{pet.name} with an energy level of #{pet.energy} of the species #{pet.species.to_s} is now the current pet."
  end

  def self.display_pet(pet)
    puts "#{pet.name} with an energy level of #{pet.energy} of the species #{pet.species.to_s}"
  end

  def self.pet_added(pet)
    puts "#{pet.name} with an energy level of #{pet.energy} of the species #{pet.species.to_s} has been added!".green
    self.bar
  end

  def self.list_pets(pets)
    pets.each {|pet| puts "#{pet.name} the #{pet.species.to_s} | Energy: #{pet.energy}".blue}
  end

  def self.pet_selection(pets)
    puts "Select a pet by name from the list below:\n"
    self.list_pets(pets)
  end
  # Food 

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

  def self.food_not_created(error)
    puts "Food was not able to be created:".red
    p error
    puts "If you wish to return to the main menu, input 'exit'".red
  end

  def self.food_missing
    puts "The selected food does not exist - try running 'add food' to add it first.".red
  end

  def self.list_foods(foods)
    puts "Available foods:".green
    foods.each {|food| puts "Name: #{food.name}, Energy: #{food.energy}".blue }
    puts "Please select food below by typing the name of it".green
  end

  # Activities

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

  # Game Actions

  def self.return_to_menu
    puts "Returning you to main menu...".blue
    self.bar
  end

  def self.actions
    puts "Available commands are:\n\nstatus\nwelcome\nactivities\nfoods\npets\nselect active pet\nadd food\nadd pet\nexit\n".green
    puts "You can always return to this menu with the 'menu' or 'home' command.".green
    puts self.bar
  end

  def self.exiting
    puts "Shutting down the game. Thanks for playing!".green
  end

  # Other

  def self.bar
    puts "~~~~~~~~~~~~~~~~~~~~"
  end

end