class PetLogger
  attr_accessor :pet

  def initialize()
    @pet = nil
  end

  def playing()
    ap "#{@pet.name} is playing...."
  end

  def finished_playing()  
    ap "#{@pet.name} is done playing!"
  end

  def sleeping()
    ap "#{@pet.name} is sleeping..."
  end

  def finished_sleeping()
    ap "#{@pet.name} is awake!"
  end

end