require_relative '../food.rb'

describe Food do 

    before(:each) do 
        @default_food = Food.new
    end

    describe 'initial state' do
        it "will initialize with default state" do
            expect(@default_food.name).to eq("Air")
            expect(@default_food.energy).to eq(0)
        end
    end
end