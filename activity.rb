
class Activity

    attr_accessor :name, :energy

    def initialize(attributes = {})
        @name = attributes[:name] ||= "Nothing"
        @energy = attributes[:energy] ||= 0
        @energy = 50 if attributes[:energy] > 50
        @energy = 0 if attributes[:energy] < 0
    end
end