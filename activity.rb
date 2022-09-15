
class Activity

    attr_accessor :name, :energy

    def initialize(attributes = {})
        @name = attributes[:name] || = "Nothing"
        @energy = attributes[:energy] || = 0
    end
end