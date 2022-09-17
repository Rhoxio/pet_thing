
class Food

    attr_accessor :name, :energy

    def initialize(attributes = {name: "Air", energy: 0})

        exceeds_threshold = !(0..energy_limit).to_a.include?(attributes[:energy])
        invalid_string = attributes[:name].length < 2
        raise ArgumentError.new("Energy levels must be between 0 and #{energy_limit}.") if exceeds_threshold
        raise ArgumentError.new("Food name must be longer than two (2) characters.") if invalid_string

        @name = attributes[:name]
        @energy = attributes[:energy] 
    end

    private

    def energy_limit
        50
    end

end