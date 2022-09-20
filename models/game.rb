class Game

  attr_accessor :current_pet, :foods, :activities, :choice, :pets

  def initialize
    @current_pet = nil
    @foods = []
    @activities = []
    @choice = nil
    @game_started = false
    @pets = []
  end

  # Need to make current pet only run if pet exists in @pets
  # This can be accomplished by adding a select pet method by name. has_pet if exists then it gets selected. Select it and set to current pet
  # Set puts w/color to identify pets available in @pets if selection doesn't match
  # Make sure messaging is correct for add pet / select pet
  def current_pet=(given_pet)
    @current_pet = given_pet
  end

  def select_pet(pet_name)
    GameLogger.already_selected_pet if pet_name == @current_pet.name
    selected_pet = @pets.select { |pet| pet.name.downcase == pet_name}[0]
    @current_pet = selected_pet
    GameLogger.select_pet(selected_pet.name)
    commands["status"].call 
  end

  def list_pets
    GameLogger.list_pets(@pets, @current_pet)
  end

  def add_pet(given_pet)
    @pets << given_pet if !has_pet?(given_pet.name)
  end

  def choose_pet
    if @pets.length < 1
      create_pet
    else
      puts
      list_pets
    end
  end

  def create_pet
    GameLogger.prompt_pet_name
    pet_name = gets.chomp.capitalize
    GameLogger.prompt_pet_species
    species = gets.chomp.to_sym


    values = {
      name: pet_name,
      species: species
    }

    begin
      ap values
      pet = Pet.new(values)
    rescue => e
      GameLogger.pet_not_added(e)
      create_pet
    else
      @pets << pet
      GameLogger.pet_added(pet)
      @current_pet = pet && @selected_pet = pet if @pets.length == 1
      return true 
    end
  end

  def has_pet?(given_pet_name)
    @pets.select do |pet|
      pet.name.downcase == given_pet_name.downcase
    end.length > 0
  end

  def select_activity(activity_name)
    @activities.select {|activity| activity.name == activity_name }[0]
  end

  def feed_pet(food_name)
    selected_food = @foods.select do |food|
      food.name.downcase == food_name.downcase
    end.first
    PetIngest.call({pet: @current_pet, food: selected_food})
    commands["status"].call
  end

  def play_pet(activity_name)
    selected_activity = @activities.select do |activity|
      activity.name.downcase == activity_name.downcase
    end.first
    PetPerform.perform({pet: @current_pet, activity: selected_activity})
    commands["status"].call
  end

  def rest()
    @current_pet.rest
    commands["status"].call
  end

  def create_food()
    GameLogger.prompt_food_name
    food_name = gets.chomp.capitalize
    GameLogger.prompt_food_energy
    energy_value = gets.chomp.to_i

    values = {
      name: food_name,
      energy: energy_value
    }

    begin
      food = Food.new(values)
    rescue => e
      GameLogger.food_not_added(e)
      create_food
    else
      @foods << food
      GameLogger.food_added(food)
      return true      
    end
    
  end

  def create_activity()
    GameLogger.prompt_activity_name
    activity_name = gets.chomp.capitalize
    GameLogger.prompt_activity_energy
    energy_value = gets.chomp.to_i
    
    values = {
      name: activity_name,
      energy: energy_value
    }

    begin
      ap values
      activity = Activity.new(values)
    rescue => e
      GameLogger.activity_not_added(e)
      create_activity
    else
      @activities << activity
      GameLogger.activity_added(activity)
      return true      
    end
    
  end

  def start()
    commands["welcome"].call if @game_started == false
    @game_started = true
    loop do
      commands["choose pet"].call if @current_pet == nil
      @choice = gets.chomp.downcase
      warn_about_missing_foods && next if (@foods.length == 0)
      warn_about_missing_activities && next if (@activities.length == 0) 
      warn_about_no_selected_pet && next if (@current_pet == nil)
      if @foods.any?{|food| food.name.downcase == @choice}
        commands(@choice)["feed"].call
      elsif @activities.any?{|activity| activity.name.downcase == @choice}
        commands(@choice)["play"].call
      elsif has_pet?(@choice)
        commands(@choice)["select pet"].call
      else
        commands[@choice].call if !!commands[@choice]
        commands["menu"].call if !commands[@choice]
        break if @choice == "exit"
      end
    end
  end


  def commands(args = nil)
    {
      "status"=> Proc.new{@current_pet.logger.pet_status},
      "add food" => Proc.new{create_food},
      "add activity" => Proc.new{create_activity},
      "feed" => Proc.new{feed_pet(args)},
      "play" => Proc.new{play_pet(args)},
      "welcome"=> Proc.new{GameLogger.welcome},
      "foods"=> Proc.new{list_foods},
      "activities"=> Proc.new{list_activities},
      "pets"=> Proc.new{list_pets},
      "select pet"=> Proc.new{select_pet(args)},
      "create pet"=> Proc.new{create_pet},
      "choose pet"=> Proc.new{choose_pet},
      "rest"=> Proc.new{rest},
      "exit"=> Proc.new{GameLogger.exit},
      "menu"=> Proc.new{GameLogger.menu}
    }
  end

  def list_foods()
    GameLogger.list_foods(@foods)
  end

  def list_activities()
    ap @current_pet
    GameLogger.list_activities(@activities, @current_pet)
  end

  private

  def warn_about_missing_foods
    warn("No foods are present yet - add some before moving on.")
  end

  def warn_about_missing_activities
    warn("No acitivites are present yet - add some before moving on.")
  end

  def warn_about_no_selected_pet
    warn("No pet selected")
    commands["list pets"].call
  end
end
