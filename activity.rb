
class Activity

    attr_accessor :name, :energy

    def initialize(attributes = {name: "", energy: 0})
        exceeds_threshold = !(0..50).to_a.include?(attributes[:energy])
        raise ArgumentError.new("Energy levels must be between 0 and #{energy_limit}.") if exceeds_threshold
        @name = attributes[:name]
        @energy = attributes[:energy]
    end

    private 

    def energy_limit
        50
    end


end