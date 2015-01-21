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

  define_method(:==) do |another_line|
    self.name().==(another_line.name()).&(self.id().==(another_line.id()))
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO train_lines (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

end
