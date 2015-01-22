class Stop
  attr_reader(:station_id, :line_id, :id)

  define_method(:initialize) do |attributes|
    @station_id = attributes.fetch(:station_id)
    @line_id = attributes.fetch(:line_id)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_stops = DB.exec("SELECT * FROM stops")
    stops = []
    returned_stops.each() do |stop|
      station_id = stop.fetch("station_id").to_i()
      line_id = stop.fetch("line_id").to_i()
      id = stop.fetch("id").to_i()
      stops.push(Stop.new({:station_id => station_id, :line_id => line_id, :id => id}))
    end
    stops
  end

  define_method(:==) do |another_stop|
    self.station_id().==(another_stop.station_id()).&(self.line_id().==(another_stop.line_id()))
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO stops (station_id, line_id) VALUES ('#{station_id}', '#{line_id}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

end
