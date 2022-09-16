require_relative 'food'
require_relative 'pet'
require_relative 'pet_ingest'
require_relative 'pet_perform'
require_relative 'activity'

class Game

  attr_accessor :current_pet, :foods, :activities

  def initialize
    @current_pet = nil
    @foods = []
    @activities = []
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

  def start()
    loop do
      user_input = gets.chomp.downcase
      ap user_input
      # case user_input
      # when "status"
      #   @current_pet.logger.pet_status
      # else
      #   ap "Incorrect command given"
      # end
      commands[user_input].call
    end
  end

  def commands()
    {
      "status": Proc.new{@current_pet.logger.pet_status}
    }
  end

end

pet = Pet.new({name: "Jake", species: :horse})
game = Game.new
game.current_pet = pet
game.start