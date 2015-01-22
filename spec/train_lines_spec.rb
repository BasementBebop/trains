require("spec_helper")


describe(Line) do

  describe(".all") do
    it("is empty at first") do
      expect(Line.all()).to(eq([]))
    end
  end

  describe("#==") do
    it("is the same line if it has the same description") do
      line1 = Line.new({:name => "NW Line", :id => 1})
      line2 = Line.new({:name => "NW Line", :id => 1})
      expect(line1).to(eq(line2))
    end
  end

  describe("#save") do
    it("adds a line to the array of saved lines") do
      test_line = Line.new({:name => "NW Line", :id => 1})
      test_line.save()
      expect(Line.all()).to(eq([test_line]))
    end
  end

  describe("#name") do
    it("lets you give it a name") do
      test_line = Line.new({:name => "NW Line", :id => 1})
      expect(test_line.name()).to(eq("NW Line"))
    end
  end

  describe("#id") do
    it("sets its ID when you save it") do
      test_line = Line.new({:name => "NW Line", :id => nil})
      test_line.save()
      expect(test_line.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#stops_on_line") do
    it("returns array of stops for that line") do
      station1 = Station.new({:name => "Portland", :id => nil})
      station1.save()
      line1 = Line.new({:name => "NW line", :id => nil})
      line1.save()
      stop1 = Stop.new({:station_id => station1.id(), :line_id => line1.id(), :id => nil})
      stop1.save()
      stop2 = Stop.new({:station_id => station1.id(), :line_id => line1.id(), :id => nil})
      stop2.save()
      expect(line1.stops_on_line()).to(eq([stop1, stop2]))
    end
  end

  describe("")

end
