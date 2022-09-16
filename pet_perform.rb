
module PetPerform

    def self.perform(attributes={})
        pet = attributes[:pet]
        activity = attributes[:activity]
        energy = activity.energy
        return pet.play()
    end
end
     