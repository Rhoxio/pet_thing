
module PetIngest
    def self.call(attributes={})
        pet = attributes[:pet]
        food = attributes[:food]
        energy = food.energy
        food_name = food.name
        return pet.eat(energy, food_name)
    end
end