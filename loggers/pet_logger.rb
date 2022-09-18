class PetLogger
  attr_accessor :pet

  def initialize
    @pet = nil
  end

  def wait
    $interval.times do |num|
      puts "Done in #{$interval - num}...".blue
      sleep 1
    end
  end

  # PLAYING

  def playing(name)
    puts "#{@pet.name} doing a #{name.downcase}".green if $puts_mode
    wait
  end

  def finished_playing(name)
    puts "#{@pet.name} is done with their #{name.downcase}!".green if $puts_mode
  end

  def cant_play(name)
    puts "#{@pet.name} is too tired to do a #{name.downcase}.".green if $puts_mode
  end

  # SLEEPING

  def sleeping
    puts "#{@pet.name} is sleeping...".green if $puts_mode
    wait
  end

  def finished_sleeping
    puts "#{@pet.name} is awake!".green if $puts_mode
  end

  def cant_sleep
    puts "#{@pet.name} is not tired.".green if $puts_mode
  end

  # EATING

  def eating(name)
    puts "#{@pet.name} is eating their #{name.downcase}".green if $puts_mode
    wait
  end

  def finished_eating
    puts "#{@pet.name} is done eating!".green if $puts_mode
  end 

  def cant_eat
    puts "#{@pet.name} is not hungry.".green if $puts_mode
  end

  # STATUS

  def pet_status
    puts "~~~~~~~~~~~~~~~~~~~~"
    puts "Pet Status:\nName: #{@pet.name}\nEnergy: #{@pet.energy}".green
    puts "~~~~~~~~~~~~~~~~~~~~"
  end

end