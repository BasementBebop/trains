require('sinatra')
require('sinatra/reloader')
also_reload('/lib/**/*.rb')
require('./lib/stops')
require('./lib/train_lines')
require('./lib/train_stations')
require('pg')

DB = PG.connect({:dbname => "train_system"})

get("/stations") do
  @stations = Station.all()
  erb(:stations)
end

get("/lines") do
  @lines = Line.all()
  erb(:lines)
end

post ("/add") do
  station_name = params.fetch("station_name")
  station = Station.new({:name => station_name, :id => nil})
  station.save()
  line_name = params.fetch("line_name")
  line = Line.new({:name => line_name, :id => nil})
  line.save()
  stop = Stop.new(:station_id => station.id(), :line_id => line.id(), :id => nil)
  stop.save()
  erb(:operator)
end

get ("/operator") do
  erb(:operator)
end



get ("/lines/:id") do
  @line = Line.find(params.fetch("id").to_i())
  erb(:view_lines)
end
#
# post ("/stops") do


get ("/stations/:id") do
  @station = Station.find(params.fetch("id").to_i())
  erb(:view_stations)
end
