describe Pet do

  before(:each) do 
    @attributes = {
      name: "Jake",
      species: :tiger
    }
    @play_energy = 20
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

    it "pet loggers are seperate instances per model" do 
      expect(@default_pet.logger == @pet.logger).to eq(false)
    end

  end

  describe 'pet functionality' do

    it "will play" do
      expect(@pet.can_play?).to eq(true)
      expect(@pet.play).to eq(true)
      expect(@pet.energy == 100).to eq(true)
    end

    it "will sleep" do
      @pet.play(@play_energy)
      @pet.play(@play_energy)
      expect(@pet.can_sleep?).to eq(true)
      expect(@pet.rest).to eq(true)
      expect(@pet.energy == 100).to eq(true)
    end

    it "will eat" do
      @pet.play(@play_energy)
      expect(@pet.can_eat?).to eq(true)
      expect(@pet.eat(20)).to eq(true)
      expect(@pet.energy == 100).to eq(true)
    end

    it "will not play" do
      @pet.energy = 0
      expect(@pet.can_play?).to eq(false)
      expect(@pet.play).to eq(false)
    end

    it "will not eat" do
      @pet.energy = 100
      expect(@pet.can_eat?).to eq(false)
      expect(@pet.eat).to eq(false)
    end

    it "will not sleep" do
      @pet.energy = 100
      expect(@pet.can_sleep?).to eq(false)
      expect(@pet.rest).to eq(false)
    end
  end

  describe "pet boolean status checks" do

    it "#can_play? will resolve default threshold" do
      expect(@pet.can_play?).to eq(true)
    end

    it "#can_eat? will resolve default threshold" do
      expect(@pet.can_eat?).to eq(false)
    end

    it "#can_sleep? will resolve default threshold" do
      expect(@pet.can_sleep?).to eq(false)
    end

    it "#can_play? will resolve false if energy is below expected threshold" do
      @pet.energy = 0
      expect(@pet.can_play?).to eq(false)
    end

    it "#can_eat? will resolve true if energy is below expected threshold" do
      @pet.energy = 20
      expect(@pet.can_eat?).to eq(true)
    end

    it "#can_sleep? will resolve true if energy is below expected threshold" do
      @pet.energy = 20
      expect(@pet.can_sleep?).to eq(true)
    end

  end

end