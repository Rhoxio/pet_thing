require_relative '../game.rb'
require 'stringio'

describe Game do 
  
  before(:each) do

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

  # describe "commands prof actions" do
  #   it "will present welcome message" do
  #     expect(@game.commands["welcome"].call).to eq("Welcome to Tomogotchi Land")
  #   end
  # end

  describe "start function" do

    it "will present welcome message" do
      game = Game.new
      allow_any_instance_of(Game).to receive(:user_input).and_return('welcome')
      expect(game.start)
    end
    
  end
  


  describe "food actions" do 
    it "will select a single food" do
      expect(@game.select_food("Fig").name).to eq("Fig")
    end
  end

  describe "activity actions" do 
    it "will select a single activity" do
      expect(@game.select_activity("Walk").name).to eq("Walk")
    end
  end

end