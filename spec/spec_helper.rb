require("rspec")
require("pg")
require("train_lines")
require("train_stations")

DB = PG.connect({:dbname => "train_system_test"})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM train_lines *;")
    DB.exec("DELETE FROM train_stations *;")
  end
end
