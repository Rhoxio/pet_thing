class Pet

  attr_accessor :name, :species, :is_sleeping, :energy
  attr_reader :logger

  def initialize(attributes = {})
    @name = attributes[:name] ||= ""
    @species = attributes[:species] ||= :canine

    @is_sleeping = false
    @energy = 100

    @logger = PetLogger.new()
    @logger.pet = self
  end

  def eat(given_energy = 0, food_name = "")
    if can_eat?
      @logger.eating(food_name)
      @energy += given_energy
      normalize_energy
      @logger.finished_eating
      return true
    else 
      @logger.cant_eat
      return false
    end
  end

  def play(given_energy = 0, activity_name = "")
    if can_play?(given_energy)
      @logger.playing(activity_name)
      @energy -= given_energy
      normalize_energy
      @logger.finished_playing(activity_name)
      return true
    else
      @logger.cant_play(activity_name)
      return false
    end
  end

  def rest
    if can_sleep?
      @logger.sleeping
      @energy += $rest_energy
      normalize_energy
      @logger.finished_sleeping
      return true
    else
      @logger.cant_sleep
      return false
    end
  end

  # _____________________

  def can_eat?
    return true if @energy <= ($energy_limits[:pet] - $eat_energy)
    return false
  end

  def can_sleep?
    return true if @energy <= ($energy_limits[:pet] - $rest_energy)
    return false
  end

  def can_play?(given_energy = 0)
    return true if @energy > given_energy
    return false
  end

  private

  def normalize_energy
    @energy = $energy_limits[:pet] if @energy > $energy_limits[:pet]
    @energy = 0 if @energy < 0
  end

end

# pet_attributes = {
#   name: "Jake",
#   species: :canine
# }

# jake = Pet.new(pet_attributes)
# jake.play

