require("spec_helper")

describe(Stop) do

  describe(".all") do
    it("starts off with no stop") do
      expect(Stop.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("lets you save stops to the database") do
      stop = Stop.new({:station_id => 1, :line_id => 1, :id => nil})
      stop.save()
      expect(Stop.all()).to(eq([stop]))
    end
  end

  describe("==") do
    it("is the same stop if it has the same station and line id") do
      stop1 =  Stop.new({:station_id => 1, :line_id => 1, :id => nil})
      stop2 =  Stop.new({:station_id => 1, :line_id => 1, :id => nil})
      expect(stop1).to(eq(stop2))
    end
  end

  describe("#station_id") do
    it("tells you its station_id") do
      stop = Stop.new({:station_id => 1, :line_id => 1, :id => nil})
      stop.save()
      expect(stop.station_id()).to(eq(1))
    end
  end

  describe("#line_id") do
    it("tells you its line_id") do
      stop = Stop.new({:station_id => 1, :line_id => 1, :id => nil})
      stop.save()
      expect(stop.line_id()).to(eq(1))
    end
  end
  

end
