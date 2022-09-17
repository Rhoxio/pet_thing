$puts_mode = true

class PetLogger
  attr_accessor :pet

  def initialize()
    @pet = nil
  end

  def playing(name)
     ap "#{@pet.name} doing a #{name.downcase}" if $puts_mode
  end

  def finished_playing(name)  
     ap "#{@pet.name} is done with their #{name.downcase}!" if $puts_mode
  end

  def cant_play(name)
     ap "#{@pet.name} is too tired to do a #{name.downcase}." if $puts_mode
  end

  def sleeping()
     ap "#{@pet.name} is sleeping..." if $puts_mode
  end

  def finished_sleeping()
     ap "#{@pet.name} is awake!" if $puts_mode
  end

  def cant_sleep()
     ap "#{@pet.name} is not tired." if $puts_mode
  end

  def eating(name)
     ap "#{@pet.name} is eating their #{name.downcase}" if $puts_mode
  end

  def finished_eating()
     ap "#{@pet.name} is done eating!" if $puts_mode
  end 

  def cant_eat()
     ap "#{@pet.name} is not hungry." if $puts_mode
  end

  def pet_status()
      ap "Pets name: #{@pet.name}. Pets energy: #{@pet.energy}"
  end

end