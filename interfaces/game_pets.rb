module GamePets

  def self.create(game, pet_values)
    begin
      pet = Pet.new(pet_values)
    rescue => e
      GameLogger.pet_not_created(e)
      return false
    end

    game.pets << pet
    GameLogger.pet_added(pet)
    return true
  end

  def self.rest(pet)
    pet.rest
  end

end