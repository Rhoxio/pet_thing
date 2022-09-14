
module PetIngest
    def self.call(attributes={})
        pet = attributes[:pet]
        food = attributes[:food]
        energy = food.energy
        return pet.eat(energy)
    end
end