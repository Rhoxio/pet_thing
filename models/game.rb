class Game

  attr_accessor :current_pet, :foods, :pets, :activities, :choice

  def initialize
    @current_pet = nil
    @pets = []
    @foods = []
    @activities = []
    @choice = nil
    @game_started = false

  end

  # GAME ACTIONS/UTILITIES

  def start
    commands["welcome"].call if @game_started == false
    commands["actions"].call
    @game_started = true
    loop do
      choice = take_user_input
      warn_about_missing_foods && next if (@foods.length == 0)
      warn_about_missing_abilities && next if (@activities.length == 0) 

      if @foods.any?{|food| food.name.downcase == choice}
        commands(choice)["feed"].call
      elsif @activities.any?{|activity| activity.name.downcase == @choice}
        commands(choice)["play"].call
      else
        commands[choice].call if !!commands[choice]
        commands[""].call if !commands[choice]
        stop if choice == "exit"
      end
    end
  end

  def stop
    abort
  end  

  def return_to_main_menu
    GameLogger.return_to_menu
    commands["welcome"].call
    commands["actions"].call
    return true
  end

  def take_user_input
    input = gets.chomp.downcase
    return return_to_main_menu if back_to_menu?(input)
    commands["exit"].call if will_exit?(input)
    return input
  end

  def back_to_menu?(input)
    ["home", "menu"].include?(input)
  end

  def will_exit?(input)
    input == "exit"
  end

  def is_valid_command?(input)
    commands.keys.include?(input)
  end

  def commands(args = nil)
    {
      "status"=> Proc.new{@current_pet.logger.pet_status},
      "actions" => Proc.new{GameLogger.actions},
      "menu" => Proc.new{return_to_main_menu},
      "home" => Proc.new{return_to_main_menu},
      "add food" => Proc.new{create_food},
      "add pet" => Proc.new{create_pet},
      "select active pet" => Proc.new{set_current_pet},
      "active pet" => Proc.new{display_current_pet},
      "feed" => Proc.new{feed_pet(args)},
      "play" => Proc.new{do_activity(args)},
      "welcome"=> Proc.new{puts "Welcome to Tomogotchi Land".blue},
      "foods"=> Proc.new{list_foods},
      "pets" => Proc.new{list_pets},
      "activities"=> Proc.new{list_activities},
      "rest"=> Proc.new{rest},
      "exit"=> Proc.new{GameLogger.exiting && stop},
      ""=> Proc.new{GameLogger.actions}
    }
  end  

  # PET

  def create_pet
    GameLogger.prompt_pet_name
    pet_name = take_user_input.capitalize
    return return_to_main_menu if back_to_menu?(pet_name)

    GameLogger.prompt_pet_species
    species_symbol = take_user_input.downcase.to_sym

    pet_values = {
      name: pet_name,
      species: species_symbol,
      energy: $energy_limits[:pet]
    }

    if GamePets.create(self, pet_values)
      commands["actions"].call
      return true
    else
      create_pet
    end

  end

  def list_pets 
    if @pets.length == 0
      warn_about_missing_pets
      commands["home"].call 
      return false
    end
    GameLogger.list_pets(@pets)
  end  

  def set_current_pet
    warn_about_missing_pets if !has_pets?
    GameLogger.pet_selection(@pets)
    pet_name = take_user_input.capitalize
    return return_to_main_menu if back_to_menu?(pet_name)

    @current_pet = select_pet(pet_name)
    GameLogger.current_pet_set(@current_pet)
    return true
  end

  def select_pet(pet_name)
    @pets.select {|pet| pet.name.downcase == pet_name.downcase}[0]
  end

  def has_pets?
    @pets.length > 0
  end

  def display_current_pet
    GameLogger.display_pet(@current_pet) if !@current_pet.nil?
  end  

  # FOOD

  def create_food
    GameLogger.prompt_food_name
    food_name = take_user_input.capitalize
    return return_to_main_menu if back_to_menu?(food_name)

    GameLogger.prompt_food_energy(food_name)
    energy_value = take_user_input.to_i  
    
    food_values = {
      name: food_name,
      energy: energy_value
    }          

    if GameFoods.create(self, food_values)
      commands["actions"].call
      return true
    else
      create_food
    end
      
  end  

  def feed_pet(food_name)
    data = {
      pet: @current_pet,
      foods: @foods,
      food_name: food_name
    }

    GameFoods.feed(data)
    commands["status"].call
  end

  def list_foods
    if has_foods?
      warn_about_missing_foods
      commands["home"].call
      return false
    end
    GameLogger.list_foods(@foods)
  end  

  def has_foods?
    @foods.length > 0
  end

  # ACTIVITIES

  def do_activity(activity_name)
    selected_activity = @activities.select do |activity|
      activity.name.downcase == activity_name.downcase
    end.first
    PetPerform.perform({pet: @current_pet, activity: selected_activity})
    commands["status"].call
  end

  def select_activity(activity_name)
    @activities.select {|activity| activity.name == activity_name }[0]
  end  

  def list_activities
    available_activities = @activities.select do |activity|
      activity.energy < @current_pet.energy
    end

    unavailable_activities = @activities.select do |activity|
      activity.energy >= @current_pet.energy
    end    

    GameLogger.list_activities(available_activities, unavailable_activities)
  end  

  # REST

  def rest
    @current_pet.rest
    commands["status"].call
  end

  private

  def warn_about_missing_abilities
    warn("No activites are present yet - add some before moving on.")
  end

  def warn_about_missing_foods
    warn("No foods are present yet - add some before moving on.") 
  end

  def warn_about_missing_pets
    warn("No pets are present yet - add some before moving on.") 
  end  
end
