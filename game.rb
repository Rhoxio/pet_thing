require_relative 'food'
require_relative 'pet'
require_relative 'pet_ingest'
require_relative 'pet_perform'
require_relative 'activity'
require 'colorize'

class Game

  attr_accessor :current_pet, :foods, :activities, :choice

  def initialize
    @current_pet = nil
    @foods = []
    @activities = []
    @choice = nil
    @game_started = false

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

  def start()
    commands["welcome"].call if @game_started == false
    @game_started = true
    loop do
      @choice = gets.chomp.downcase
      warn("No foods are present yet - add some before moving on.") && next if (@foods.length == 0)
      warn("No acitivites are present yet - add some before moving on.") && next if (@activities.length == 0) 

      if @foods.any?{|food| food.name.downcase == @choice}
        commands(@choice)["feed"].call
      elsif @activities.any?{|activity| activity.name.downcase == @choice}
        commands(@choice)["play"].call
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
      "feed" => Proc.new{feed_pet(args)},
      "play" => Proc.new{play_pet(args)},
      "welcome"=> Proc.new{puts "Welcome to Tomogotchi Land".blue},
      "menu"=> Proc.new{list_menu},
      "activities"=> Proc.new{list_activities},
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
game.current_pet = pet
game.current_pet.energy = 80
game.foods = [Food.new(name: "Burger", energy: 20), Food.new(name: "Sushi", energy: 30)]
game.activities = [Activity.new(name: "Run", energy: 40), Activity.new(name: "Marathon", energy: 50), Activity.new(name: "Walk", energy: 10)]
game.start