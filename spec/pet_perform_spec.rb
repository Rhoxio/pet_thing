describe PetPerform do

    before(:each) do
        $interval = 0
        @default_activity = Activity.new
        @default_pet = Pet.new
        @walk_activity = Activity.new({name: "Walk", energy: 15})
        @run_activity = Activity.new({name: "", energy: 49})

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

            it "will not perform at zero energy" do
                @custom_pair[:pet].energy = 0
                expect(PetPerform.perform(@custom_pair)).to eq(false)
            end

            it "will not perform at above zero energy" do 
                @custom_pair[:pet].energy = 20
                @custom_pair[:activity] = @run_activity
                expect(PetPerform.perform(@custom_pair)).to eq(false)
            end
        end
    end


end