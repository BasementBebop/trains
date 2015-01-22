require("spec_helper")

describe(Station) do

  describe(".all") do
    it("is empty at first") do
      expect(Station.all()).to(eq([]))
    end
  end

  describe("#==") do
    it("is the same station if it has the same description") do
      station1 = Station.new({:name => "NW Station", :id => 1})
      station2 = Station.new({:name => "NW Station", :id => 1})
      expect(station1).to(eq(station2))
    end
  end

  describe("#save") do
    it("adds a station to the array of saved stations") do
      test_station = Station.new({:name => "NW Station", :id => 1})
      test_station.save()
      expect(Station.all()).to(eq([test_station]))
    end
  end

  describe("#name") do
    it("lets you give it a name") do
      test_station = Station.new({:name => "NW Station", :id => 1})
      expect(test_station.name()).to(eq("NW Station"))
    end
  end

  describe("#id") do
    it("sets its ID when you save it") do
      test_station = Station.new({:name => "NW Station", :id => nil})
      test_station.save()
      expect(test_station.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#stops_on_station") do
    it("returns array of stops for that station") do
      station1 = Station.new({:name => "Portland", :id => nil})
      station1.save()
      line1 = Line.new({:name => "NW line", :id => nil})
      line1.save()
      stop1 = Stop.new({:station_id => station1.id(), :line_id => line1.id(), :id => nil})
      stop1.save()
      stop2 = Stop.new({:station_id => station1.id(), :line_id => line1.id(), :id => nil})
      stop2.save()
      expect(station1.stops_on_station()).to(eq([stop1, stop2]))
    end
  end

end
