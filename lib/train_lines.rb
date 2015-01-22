class Line

  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_lines = DB.exec("SELECT * FROM train_lines;")
    lines = []
    returned_lines.each() do |line|
      name = line.fetch("name")
      id = line.fetch("id").to_i()
      lines.push(Line.new({:name => name, :id => id}))
    end
    lines
  end

  define_singleton_method(:find) do |id|
    found_line = nil
    Line.all().each() do |line|
      if line.id().eql?(id)
        found_line = line
      end
    end
    found_line
  end

  define_method(:==) do |another_line|
    self.name().==(another_line.name()).&(self.id().==(another_line.id()))
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO train_lines (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:stops_on_line) do
    line_stops = []
    stops = DB.exec("SELECT * FROM stops WHERE line_id = #{self.id()};")
    stops.each() do |stop|
      station_id = stop.fetch("station_id").to_i()
      line_id = stop.fetch("line_id").to_i()
      id = stop.fetch("id").to_i()
      line_stops.push(Stop.new({:station_id => station_id, :line_id => line_id, :id => id}))
    end
    line_stops
  end

  define_method(:get_line_name) do
    line_names = []
    lines = DB.exec("SELECT * FROM train_lines WHERE line_id = #{self.id()}")
    lines.each() do |line|
      line_name = line.fetch("line_name")
      id = line.fetch("id").to_i()
      line_names.push(Line.new({:name => line_name, :id => id})) 
    end
    line_names
  end

end
