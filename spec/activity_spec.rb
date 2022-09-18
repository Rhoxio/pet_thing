require_relative '../activity.rb'

describe Activity do 
  describe "errors" do 

    it "errors out when energy over 50 is supplied" do 
      expect{Activity.new({name: "test", energy: 51})}.to raise_error(ArgumentError)
    end

       it "errors out when energy under 0 is supplied" do 
      expect{Activity.new({name: "test", energy: -1})}.to raise_error(ArgumentError)
    end 
  end

  describe "defaults" do 
    it "will contain correct data in initial state" do 
      activity = Activity.new
      expect(activity.energy).to eq(0)
      expect(activity.name).to eq("")
    end

    it "will contain correct data in custom state" do 
      activity = Activity.new({name: "Walk", energy: 20})
      expect(activity.energy).to eq(20)
      expect(activity.name).to eq("Walk")
    end    
  end


end