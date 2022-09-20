module GameLogger

    # Game Prompts
    def self.welcome
        puts "Welcome to Tomogotchi Land".blue
    end

    def self.exit
        puts "Thanks for coming to Tomogotchi Land".green
    end

    def self.menu
        puts "Please make a choice between \nstatus\nmenu\npets\nactivities\nfoods\nadd food\nadd activity\ncreate pet\nrest\nexit".green
    end


    # Pet Prompts
    def self.select_pet(pet_name)
        puts "#{pet_name} selected!".green  
    end 

    def self.already_selected_pet(pet_name)
        puts "#{pet_name} is already selected.".red
    end

    def self.list_pets(pets, current_pet)
        available_pets = pets.select do |pet|
            pet != current_pet
          end
      
          unavailable_pet = pets.select do |pet|
            pet == current_pet
          end.first

          if available_pets.length == 0
            puts "No other pets to select. #{current_pet.name} is already selected.".red
            puts "To add another pet enter\n\ncreate pet".blue

          else
      
          puts "Please select a pet below\n".blue
          
          available_pets.each {|pet| puts "Name: #{pet.name}\nSpecies: #{pet.species}".green}
          puts "\nPet currently selected: #{unavailable_pet.name}".red

          end
    end

    def self.prompt_pet_name
        puts "Enter a name for your pet:".blue
    end

    def self.prompt_pet_species
        puts "Enter a species for your pet:".blue
    end

    def self.pet_added(pet)
        puts "#{pet.name} of species #{pet.species} has been added!".green
    end

    def self.pet_not_added(e)
        puts "pet was not able to be created:".red
        p e
    end



    # Food Prompts

    def self.list_foods(foods)
        puts "Here's the menu\nPlease select food below\n".blue
        foods.each {|food| puts "Name: #{food.name}\nEnergy: #{food.energy}".green}
    end

    def self.food_added(food)
        puts "#{food.name} with an energy level of #{food.energy} has been added!".green
    end

    def self.food_not_added(e)
        puts "Food was not able to be created:".red
        p e   
    end

    def self.prompt_food_name
        puts "Enter a name for a food:".blue
    end

    def self.prompt_food_energy
        puts "Enter an energy level for a food:".blue
    end

    # Activity Prompts

    def self.list_activities(activities, current_pet)
        available_activities = activities.select do |activity|
            activity.energy < current_pet.energy
        end
      
        unavailable_activities = activities.select do |activity|
            activity.energy >= current_pet.energy
        end    
      
        puts "Please select an activity below by typing the name of it".blue
      
        available_activities.each {|activity| puts "Activity: #{activity.name}\nEnergy: #{activity.energy}".green}
        unavailable_activities.each {|activity| puts "Activity: #{activity.name}\nEnergy: #{activity.energy}".red}
    end

    def self.activity_added(activity)
        puts "#{activity.name} with an energy level of #{activity.energy} has been added!".green
    end

    def self.activity_not_added(e)
        puts "activity was not able to be created:".red
        p e
    end

    def self.prompt_activity_name
        puts "Enter a name for an activity:".blue
    end

    def self.prompt_activity_energy
        puts "Enter an energy level for an activity:".blue
    end
    
end