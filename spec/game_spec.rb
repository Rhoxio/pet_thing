require_relative '../game.rb'
require 'stringio'

describe Game do 
  
  before(:each) do
    $interval = 0
    
    @game = Game.new

    @pet = Pet.new({name: "Jake", species: :horse})

    @foods = [
      Food.new({name: "Fig", energy: 10}), 
      Food.new({name: "Apple", energy: 5})
    ]

    @activities = [
      Activity.new({name: "Walk", energy: 5}),
      Activity.new({name: "Run", energy: 45})
    ]

    @game.foods = @foods
    @game.activities = @activities
    @game.current_pet = @pet
   
  end

  describe "initial state" do 

    it "will not initialize with a current_pet" do 
      game = Game.new
      expect(game.current_pet).to eq(nil)
    end

    it "will initialize with blank arrays for foods and activities" do 
      game = Game.new
      expect(game.foods).to eq([])
      expect(game.activities).to eq([])
    end

  end

  describe "start function" do

    # it "will present welcome message" do
    #   game = Game.new
    #   game.start
    #   game.choice = "welcome"
    #   expect do
    #   end.to output("Welcome to Tomogotchi Land").to_stdout
    # end
    
  end
  
  describe "food actions" do 
    it "will eat food" do
      
      @game.current_pet.energy = 40
      @game.feed_pet(@game.foods[0].name)

      expect(@game.current_pet.energy).to eq(50)
    end

    it "will not eat food" do
      @game.current_pet.energy = 90
      @game.feed_pet(@game.foods[0].name)

      expect(@game.current_pet.energy).to eq(90)

    end

  end

  describe "activity actions" do 
    it "will perform activity" do
      @game.current_pet.energy = 6
      @game.play_pet(@game.activities[0].name)

      expect(@game.current_pet.energy).to eq(1)
    end

    it "will not perform activity" do
      @game.current_pet.energy = 1
      @game.play_pet(@game.activities[0].name)

      expect(@game.current_pet.energy).to eq(1)
    end
  end

  describe "rest actions" do
    it "will rest" do
      @game.current_pet.energy = 60
      @game.rest

      expect(@game.current_pet.energy).to eq(100)
    end

    it "will not rest" do
      @game.current_pet.energy = 61
      @game.rest

      expect(@game.current_pet.energy).to eq(61)
    end

  end

end