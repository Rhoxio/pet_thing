require_relative 'food'
require_relative 'pet'
require_relative 'pet_ingest'
require_relative 'pet_perform'
require_relative 'activity'
require 'stringio'

class Game

  attr_accessor :current_pet, :foods, :activities, :output, :input

  def initialize
    @current_pet = nil
    @foods = []
    @activities = []
    @choice = nil
    @game_started = false

  end

  def select_food(food_name)
    @foods.select do |food| 
      food.name == food_name 
    end.first
  end

  def select_activity(activity_name)
    @activities.select {|activity| activity.name == activity_name }[0]
  end

  def execute_prompt()
  end

  def feed_pet(food_name)
    selected_food = @foods.select do |food|
      food.name.downcase == food_name
    end.first
    if @current_pet.energy == 100
      @current_pet.logger.cant_eat
    else
      @current_pet.logger.eating
      PetIngest.call({pet: @current_pet, food: selected_food})
      @current_pet.logger.finished_eating
      commands["status"].call
    end
  end

  def play_pet(activity_name)
    selected_activity = @activities.select do |activity|
      activity.name.downcase == activity_name
    end.first
    if @current_pet.energy <= selected_activity.energy
      @current_pet.logger.cant_play
    else
      @current_pet.logger.playing
      PetPerform.perform({pet: @current_pet, activity: selected_activity})
      @current_pet.logger.finished_playing
      commands["status"].call
    end
  end

  def start()
    commands["welcome"].call if @game_started == false
    @game_started = true
    loop do
      @choice = gets.chomp.downcase
      ap @choice
      if @foods.any?{|food| food.name.downcase == @choice}
        feed_pet(@choice)
      elsif @activities.any?{|activity| activity.name.downcase == @choice}
        play_pet(@choice)
      else
      commands[@choice].call if !!commands[@choice]
      break if @choice == "exit"
      end
    end
  end


  def commands()
    {
      "status"=> Proc.new{@current_pet.logger.pet_status},
      "welcome"=> Proc.new{ap "Welcome to Tomogotchi Land"},
      "menu"=> Proc.new{ap "Here's the menu" and @foods.each {|food| puts "Name: #{food.name} : Energy: #{food.energy}"} and ap "Select menu item to feed your pet"},
      "activities"=> Proc.new{list_activities},
      "exit"=> Proc.new{ap "Thanks for coming to Tomogotchi Land"},
      ""=> Proc.new{ap "Please make a choice between status, welcome, menu, activities, and exit"}
    }
  end

  def feed_command()

    
  
  end

  def list_activities()
    selected_activity = @activities.select do |activity|
      activity.energy < @current_pet.energy
    end
    ap "Please select an activity below"
    selected_activity.each {|activity| ap "Activity: #{activity.name} | Energy: #{activity.energy}"}
  end

  private 


end

pet = Pet.new({name: "Jake", species: :horse})
game = Game.new
game.current_pet = pet
game.current_pet.energy = 80
game.foods = [Food.new(name: "Burger", energy: 20)]
game.activities = [Activity.new(name: "Run", energy: 40), Activity.new(name: "Marathon", energy: 50), Activity.new(name: "Walk", energy: 10)]
game.start