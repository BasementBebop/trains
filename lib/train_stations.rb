class Station

  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_stations = DB.exec("SELECT * FROM train_stations;")
    stations = []
    returned_stations.each() do |station|
      name = station.fetch("name")
      id = station.fetch("id").to_i()
      stations.push(Station.new({:name => name, :id => id}))
    end
    stations
  end

  define_singleton_method(:find) do |id|
    found_station = nil
    Station.all().each() do |station|
      if station.id().eql?(id)
        found_station = station
      end
    end
    found_station
  end

  define_method(:stops_on_station) do
    station_stops = []
    stops = DB.exec("SELECT * FROM stops WHERE station_id = #{self.id()};")
    stops.each() do |stop|
      station_id = stop.fetch("station_id").to_i()
      line_id = stop.fetch("line_id").to_i()
      id = stop.fetch("id").to_i()
      station_stops.push(Stop.new({:station_id => station_id, :line_id => line_id, :id => id}))
    end
    station_stops
  end


  define_method(:==) do |another_station|
    self.name().==(another_station.name()).&(self.id().==(another_station.id()))
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO train_stations (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

end
