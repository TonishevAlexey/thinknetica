require_relative './modules/instance_counter'

class Station
  # Может возвращать список всех поездов на станции, находящиеся в текущий момент
  attr_reader :trains, :name
  @@station_all = []
  #   Имеет название, которое указывается при ее создании
  def initialize(name)
    @name = name
    @trains = []
    @@station_all << self
  end

  # Может принимать поезда (по одному за раз)
  def add_trains(train)
    @trains << train.number
  end

  # Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
  def run_trains(station, train)
    station.add_trains(train)
    @trains.delete(train)
  end

  # Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
  def trains_type(type)
    n = []
    @trains.each { |train| n << @trains if train.class == type.class }
    n
  end

  def self.all
    @@station_all
  end

end
a=Station.new("a")
r=Station.new("a")
b=Station.new("a")
puts Station.all
