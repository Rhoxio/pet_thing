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
            it "will perform" do
                expect(PetPerform.perform(@default_pair)).to eq(true)
            end

            it "will not perform" do
                @default_pair[:pet].energy = 0
                expect(PetPerform.perform(@default_pair)).to eq(false)
            end
        end

        describe 'custom' do
            it "will perform" do
                expect(PetPerform.perform(@custom_pair)).to eq(true)
            end

            it "will not perform" do
                @custom_pair[:pet].energy = 10
                expect(PetPerform.perform(@custom_pair)).to eq(true)
            end
        end
    end


end