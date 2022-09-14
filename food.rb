
class Food

    attr_accessor :name, :energy
    def initialize(attributes = {})
        @name = attributes[:name] ||= "Air"
        @energy = attributes[:energy] ||= 0
    end

end