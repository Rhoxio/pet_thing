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

end