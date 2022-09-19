describe GameFoods do 

  before(:each) do 
    @pet = Pet.new({name: "Jake", species: :horse})
    @game = Game.new
    @game.current_pet = @pet
    @game.foods = [Food.new(name: "Burger", energy: 20), Food.new(name: "Sushi", energy: 30)]
  end

  describe "create action" do
    it "will create a food" do 
      food_values = {
        name: "Ramen",
        energy: 10
      }        
      expect(GameFoods.create(@game, food_values)).to eq(true)
      expect(@game.foods.any?{|food| food.name == "Ramen"})
    end  
  end

  describe "pet actions in game context" do
    it "will warn about food not existing and return false" do 
      data = {
        pet: @game.current_pet,
        foods: @game.foods,
        food_name: "Papaya"
      }

      expect(GameFoods.feed(data)).to eq(false)
    end

    it "will feed current_pet" do 
      @game.current_pet.energy = 80
      expect(@game.current_pet.energy).to eq(80)

      data = {
        pet: @game.current_pet,
        foods: @game.foods,
        food_name: "Burger"
      }
      
      response = GameFoods.feed(data)
      expect(response).to eq(true)
      expect(@game.current_pet.energy).to eq(100)
    end  
  end

end