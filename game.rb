require_relative 'food'
require_relative 'pet'
require_relative 'pet_ingest'
require_relative 'pet_perform'
require_relative 'activity'
require 'colorize'

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
    selected_pet = @pets.select { |pet| pet.name.downcase == pet_name}[0]
    @current_pet = selected_pet
    puts "#{@current_pet.name} selected!"
    commands["status"].call 
  end

  def list_pets
    available_pets = @pets.select do |pet|
      pet != @current_pet
    end

    unavailable_pets = @pets.select do |pet|
      pet == @current_pet
    end

    puts "Please select a pet below".blue

    available_pets.each {|pet| puts "Name: #{pet.name} | Species: #{pet.species}".green}
    unavailable_pets.each {|pet| puts "Name: #{pet.name} | Species: #{pet.species}".red}
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
    puts "Enter a name for a pet:".blue
    pet_name = gets.chomp.capitalize
    puts "Enter an energy level for a pet:".blue
    species = gets.chomp.to_sym


    values = {
      name: pet_name,
      species: species
    }

    begin
      ap values
      pet = Pet.new(values)
    rescue => e
      puts "pet was not able to be created:".red
      p e
      create_pet
    else
      @pets << pet
      puts "#{pet.name} of species #{pet.species} has been added!".green
      @current_pet = pet if @pets.length < 0
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
    puts "Enter a name for a food:".blue
    food_name = gets.chomp.capitalize
    puts "Enter an energy level for a food:".blue
    energy_value = gets.chomp.to_i

    values = {
      name: food_name,
      energy: energy_value
    }

    begin
      ap values
      food = Food.new(values)
    rescue => e
      puts "Food was not able to be created:".red
      p e
      create_food
    else
      @foods << food
      puts "#{food.name} with an energy level of #{food.energy} has been added!".green
      return true      
    end
    
  end

  def create_activity()
    puts "Enter a name for a activity:".blue
    activity_name = gets.chomp.capitalize
    puts "Enter an energy level for a activity:".blue
    energy_value = gets.chomp.to_i
    
    values = {
      name: activity_name,
      energy: energy_value
    }

    begin
      ap values
      activity = Activity.new(values)
    rescue => e
      puts "activity was not able to be created:".red
      p e
      create_activity
    else
      @activities << activity
      puts "#{activity.name} with an energy level of #{activity.energy} has been added!".green
      return true      
    end
    
  end

  def start()
    commands["welcome"].call if @game_started == false
    @game_started = true
    loop do
      commands["choose pet"].call if @current_pet == nil
      @choice = gets.chomp.downcase
      warn("No foods are present yet - add some before moving on.") && next if (@foods.length == 0)
      warn("No acitivites are present yet - add some before moving on.") && next if (@activities.length == 0) 
      if @foods.any?{|food| food.name.downcase == @choice}
        commands(@choice)["feed"].call
      elsif @activities.any?{|activity| activity.name.downcase == @choice}
        commands(@choice)["play"].call
      elsif has_pet?(@choice)
        commands(@choice)["select pet"].call
      else
        commands[@choice].call if !!commands[@choice]
        commands[""].call if !commands[@choice]
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
      "welcome"=> Proc.new{puts "Welcome to Tomogotchi Land".blue},
      "menu"=> Proc.new{list_menu},
      "activities"=> Proc.new{list_activities},
      "list pets"=> Proc.new{list_pets},
      "select pet"=> Proc.new{select_pet(args)},
      "create pet"=> Proc.new{create_pet},
      "choose pet"=> Proc.new{choose_pet},
      "rest"=> Proc.new{rest},
      "exit"=> Proc.new{puts "Thanks for coming to Tomogotchi Land".green},
      ""=> Proc.new{puts "Please make a choice between status, welcome, menu, activities, rest and exit".green}
    }
  end

  def list_menu()
    ap "Here's the menu"
    ap "Please select food below by typing the name of it"
    @foods.each {|food| ap "Name: #{food.name} : Energy: #{food.energy}"}
  end

  def list_activities()
    available_activities = @activities.select do |activity|
      activity.energy < @current_pet.energy
    end

    unavailable_activities = @activities.select do |activity|
      activity.energy >= @current_pet.energy
    end    

    ap "Please select an activity below by typing the name of it"

    available_activities.each {|activity| puts "Activity: #{activity.name} | Energy: #{activity.energy}".green}
    unavailable_activities.each {|activity| puts "Activity: #{activity.name} | Energy: #{activity.energy}".red}
  end
end

pet = Pet.new({name: "Jake", species: :horse})
game = Game.new
# game.current_pet = pet
# game.current_pet.energy = 80
game.foods = [Food.new(name: "Burger", energy: 20), Food.new(name: "Sushi", energy: 30)]
game.activities = [Activity.new(name: "Run", energy: 40), Activity.new(name: "Marathon", energy: 50), Activity.new(name: "Walk", energy: 10)]
new_pet = Pet.new({name: "Bob", species: :crocodile})
# game.pets = [pet, new_pet]
game.start