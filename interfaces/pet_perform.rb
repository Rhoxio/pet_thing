module PetPerform
    def self.perform(attributes={})
        pet = attributes[:pet]
        activity = attributes[:activity]
        energy = activity.energy
        activity_name = activity.name
        return pet.play(energy, activity_name)
    end
end
     