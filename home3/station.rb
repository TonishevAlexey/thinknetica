# Класс Station (Станция):
#   Имеет название, которое указывается при ее создании
# Может принимать поезда (по одному за раз)
# Может возвращать список всех поездов на станции, находящиеся в текущий момент
# Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
# Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_trains(train)
    @trains << train.number
  end
  def run_trains(station,train)
    station.add_trains(train)
    @trains.delete(train)
  end
  def trains_type(type)
    n=0
    @trains.each { |train| n+=1 if @trains.type == type}
    n
  end
end

