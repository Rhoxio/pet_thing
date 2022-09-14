require 'awesome_print'
require_relative 'pet_logger'

SLEEP_ENERGY = 40
PLAY_ENERGY = 20

PET_LOGGER = PetLogger.new()

class Pet

  attr_accessor :name, :species, :is_sleeping, :energy

  def initialize(attributes = {})
    @name = attributes[:name] ||= ""
    @species = attributes[:species] ||= :canine

    @is_sleeping = false
    @energy = 100
    PET_LOGGER.pet = self
  end

  def eat
  end

  def play
    if can_play?
      PET_LOGGER.playing
      sleep 2
      @energy -= PLAY_ENERGY
      normalize_max_energy
      PET_LOGGER.finished_playing()
      return true
    else
      ap "#{@name} is too tired to play..."
      return false
    end
  end

  def rest
    if can_sleep?
      PET_LOGGER.sleeping()
      sleep 2
      @energy += SLEEP_ENERGY
      normalize_max_energy
      PET_LOGGER.finished_sleeping()
      return true
    else
      ap "#{@name} is not tired."
      return false
    end
  end

  # _____________________

  def can_eat?
  end

  def can_sleep?
    return true if @energy <= (max_energy - SLEEP_ENERGY)
    return false
  end

  def can_play?
    return true if @energy > 30
    return false
  end

  private

  def max_energy
    100
  end

  def normalize_max_energy
    @energy = max_energy if @energy > max_energy
  end

end

pet_attributes = {
  name: "Jake",
  species: :canine
}

jake = Pet.new(pet_attributes)
jake.play

