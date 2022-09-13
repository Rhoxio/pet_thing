module PetLogger

  def self.playing(pet)
    ap "#{pet.name} is playing...."
  end

  def self.finished_playing(pet)  
    ap "#{pet.name} is done playing!"
  end

  def self.sleeping(pet)
    ap "#{pet.name} is sleeping..."
  end

  def self.finished_sleeping(pet)
    ap "#{pet.name} is awake!"
  end

end