
class Activity

    attr_accessor :name, :energy

    def initialize(attributes = {name: "Stay", energy: 0})
        Validator.validate_energy_limit(self, attributes[:energy])
        Validator.validate_name_length(attributes[:name])

        @name = attributes[:name]
        @energy = attributes[:energy]
    end

end