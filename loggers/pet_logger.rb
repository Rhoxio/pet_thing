class PetLogger
  attr_accessor :pet

  def initialize()
    @pet = nil
  end

  def playing(name)
     puts "#{@pet.name} doing a #{name.downcase}".green if $puts_mode
  end

  def finished_playing(name)  
     puts "#{@pet.name} is done with their #{name.downcase}!".blue if $puts_mode
  end

  def cant_play(name)
     puts "#{@pet.name} is too tired to do a #{name.downcase}.".red if $puts_mode
  end

  def sleeping()
     puts "#{@pet.name} is sleeping...".green if $puts_mode
  end

  def finished_sleeping()
     puts "#{@pet.name} is awake!".blue if $puts_mode
  end

  def cant_sleep()
     puts "#{@pet.name} is not tired.".red if $puts_mode
  end

  def eating(name)
     puts "#{@pet.name} is eating their #{name.downcase}".green if $puts_mode
  end

  def finished_eating()
     puts "#{@pet.name} is done eating!".blue if $puts_mode
  end 

  def cant_eat()
     puts "#{@pet.name} is not hungry.".red if $puts_mode
  end

  def pet_status()
      puts "Pets name: #{@pet.name}. Pets energy: #{@pet.energy}".blue
  end

end