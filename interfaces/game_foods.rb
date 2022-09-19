module GameFoods

  def self.create(game, food_values)
  
    begin
      food = Food.new(food_values)
    rescue => e
      GameLogger.food_not_created(e)
      return false
    end    

    game.foods << food
    GameLogger.food_added(food)    
    return true
  end

  def self.feed(args = {pet: nil, foods: [], food_name: nil})
    pet = args[:pet]
    foods = args[:foods]
    food_name = args[:food_name]

    self.validate_pet_object(pet)
    self.validate_foods_array(foods)

    selected_food = foods.select do |food|
      food.name.downcase == food_name.downcase
    end.first

    if !selected_food
      GameLogger.food_missing
      return false
    else
      PetIngest.call({pet: pet, food: selected_food}) if selected_food
      return true      
    end

  end

  private

  def self.validate_pet_object(pet)
    raise ArgumentError.new("Must supply a pet object to be fed.") if !pet.is_a?(Pet)
  end

  def self.validate_foods_array(foods)
    raise ArgumentError.new("Must supply a set of Food objects.") if foods.any?{|food| !food.is_a?(Food)}
  end

end