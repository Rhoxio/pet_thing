$puts_mode = true

class PetLogger
  attr_accessor :pet

  def initialize()
    @pet = nil
  end

  def playing()
     ap "#{@pet.name} is playing...." if $puts_mode
  end

  def finished_playing()  
     ap "#{@pet.name} is done playing!" if $puts_mode
  end

  def cant_play()
     ap "#{@pet.name} is too tired to play." if $puts_mode
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

  def eating()
     ap "#{@pet.name} is eating..." if $puts_mode
  end

  def finished_eating()
     ap "#{@pet.name} is done eating!" if $puts_mode
  end 

  def cant_eat()
     ap "#{@pet.name} is not hungry." if $puts_mode
  end

end