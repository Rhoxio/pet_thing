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
      sleep $interval
      @energy += given_energy
      normalize_max_energy
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
      sleep $interval
      @energy -= given_energy
      normalize_max_energy
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
      sleep $interval
      @energy += SLEEP_ENERGY
      normalize_max_energy
      @logger.finished_sleeping
      return true
    else
      @logger.cant_sleep
      return false
    end
  end

  # _____________________

  def can_eat?
    return true if @energy <= (max_energy - EAT_ENERGY)
    return false
  end

  def can_sleep?
    return true if @energy <= (max_energy - SLEEP_ENERGY)
    return false
  end

  def can_play?(given_energy = 0)
    return true if @energy > given_energy
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

# pet_attributes = {
#   name: "Jake",
#   species: :canine
# }

# jake = Pet.new(pet_attributes)
# jake.play

