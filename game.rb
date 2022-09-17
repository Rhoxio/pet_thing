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
      food.name == food_name
    end.first
    ap "#{@current_pet.name} is eating #{selected_food.name}"
    # print "this is the selected food #{selected_food}"
    PetIngest.call({pet: @current_pet, food: selected_food})
    ap "#{@current_pet.name} is fed"
    commands["status"].call
  end

  def start()
    commands["welcome"].call if @game_started == false
    @game_started = true
    loop do
      @choice = gets.chomp
      ap @choice
      if @foods.any?{|food| food.name == @choice}
        feed_pet(@choice)
      else
      commands[@choice].call
      break if @choice == "exit"
      end
    end
  end


  def commands()
    {
      "status"=> Proc.new{@current_pet.logger.pet_status},
      "welcome"=> Proc.new{ap "Welcome to Tomogotchi Land"},
      "feed"=> Proc.new{PetIngest.call({pet: @current_pet, food: @foods[0]})},
      "menu"=> Proc.new{ap "Here's the menu" and @foods.each {|food| puts "Name: #{food.name} : Energy: #{food.energy}"} and ap "Select menu item to feed your pet"},
      "exit"=> Proc.new{ap "Thanks for coming to Tomogotchi Land"},
      ""=> Proc.new{ap "Please make a choice between status, welcome, feed, menu, and exit"}
      
    }
  end

  def feed_command()
    
  
  end

  private 


end

pet = Pet.new({name: "Jake", species: :horse})
game = Game.new
game.current_pet = pet
game.current_pet.energy = 20
game.foods = [Food.new(name: "Burger", energy: 20)]
game.start