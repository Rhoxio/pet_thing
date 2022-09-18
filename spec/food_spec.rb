require_relative '../food.rb'

describe Food do 

    before(:each) do 
        @default_food = Food.new
        @energy_limit = 50
    end

    describe 'initial state' do
        it "will initialize with default state" do
            expect(@default_food.name).to eq("Air")
            expect(@default_food.energy).to eq(0)
        end
    end

    describe "custom state" do 
        it "will take custom data" do 
            food = Food.new({name: "Fig", energy: 5})
            expect(food.name).to eq("Fig") 
            expect(food.energy).to eq(5) 
        end
    end

    describe 'invalid states' do 
        it "will not accept short names" do 
            expect{Food.new({name: "A", energy: 5})}.to raise_error(ArgumentError)
        end

        it "will not accept energy over max" do 
            expect{Food.new({name: "Artichoke", energy: 55})}.to raise_error(ArgumentError)
        end
        
        it "will not accept energy under min" do
            expect{Food.new({name: "", energy: -1})}.to raise_error(ArgumentError)
        end
    end

end