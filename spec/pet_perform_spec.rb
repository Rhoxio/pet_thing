require_relative '../activity.rb'
require_relative '../pet.rb'
require_relative '../pet_perform.rb'

describe PetPerform do

    before(:each) do
        $interval = 0
        @default_activity = Activity.new
        @default_pet = Pet.new
        @walk_activity = Activity.new({name: "Walk", energy: 15})
        @default_pair = {
            pet: @default_pet,
            activity: @default_activity
        }
        @custom_pair = {
            pet: @default_pet,
            activity: @walk_activity
        }
    end

    describe "functionality" do
        describe 'default' do
            it "will call" do
                expect(PetPerform.perform(@default_pair)).to eq(true)
            end
        end
    end

end