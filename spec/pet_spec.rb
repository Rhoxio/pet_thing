require_relative '../pet.rb'

describe Pet do

  before(:each) do 
    @attributes = {
      name: "Jake",
      species: :tiger
    }

    @default_pet = Pet.new
    @pet = Pet.new(@attributes)
  end

  describe 'initial state' do 

    it "will initialize with default state" do 
      expect(@default_pet.name).to eq("")
      expect(@default_pet.species).to eq(:canine)
      expect(@default_pet.is_sleeping).to eq(false)
      expect(@default_pet.energy).to eq(100)
      expect(@default_pet.logger.class).to eq(PetLogger)
      expect(@default_pet.logger.pet).to eq(@default_pet)
    end

    it "will initialize with custom data" do 
      expect(@pet.name).to eq("Jake")
      expect(@pet.species).to eq(:tiger)
      expect(@pet.is_sleeping).to eq(false)
      expect(@pet.energy).to eq(100)
    end

    it "will got set new logger" do
      expect(@pet.respond_to?(:logger)).to eq(true) 
      expect(@pet.respond_to?(:logger=)).to eq(false) 
    end

    it "will sandbox" do 

    end

  end

end