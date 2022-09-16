require_relative '../food.rb'
require_relative '../pet.rb'
require_relative '../pet_ingest.rb'

describe PetIngest do 

    before(:each) do 
        $interval = 0
        @default_food = Food.new
        @default_pet = Pet.new
        @burger_food = Food.new({name: "burger", energy: 20})
        @default_pair = {
            pet: @default_pet,
            food: @default_food
        }
        @custom_pair = {
            pet: @default_pet,
            food: @burger_food
        }
        
    end

    describe 'functionality' do
        describe 'default' do
            it "will call" do
                # Energy level of pet is defaulted to 100, so even adding 0 keeps energy at 100
                expect(PetIngest.call(@default_pair)).to eq(false)
            end
        end

        describe 'custom' do
            it "will call" do
                expect(PetIngest.call(@custom_pair)).to eq(false)
            end
            it "will gain energy" do
                @custom_pair[:pet].energy = 80
                expect(PetIngest.call(@custom_pair)).to eq(true)
            end
            it "energy will cap if over threshold" do
                @custom_pair[:pet].energy = 60
                @custom_pair[:food].energy = 50
                expect(PetIngest.call(@custom_pair)).to eq(true)
                expect(@custom_pair[:pet].energy).to eq(100)
            end
            it "will not gain energy" do
                @custom_pair[:pet].energy = 100
                @custom_pair[:food].energy = 10
                expect(PetIngest.call(@custom_pair)).to eq(false)
            end
            
        end
    end
end