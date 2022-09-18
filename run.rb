require_relative "environment"

pet = Pet.new({name: "Jake", species: :horse})
game = Game.new
game.current_pet = pet
game.current_pet.energy = 80
game.foods = [Food.new(name: "Burger", energy: 20), Food.new(name: "Sushi", energy: 30)]
game.activities = [Activity.new(name: "Run", energy: 40), Activity.new(name: "Marathon", energy: 50), Activity.new(name: "Walk", energy: 10)]
game.start