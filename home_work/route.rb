require_relative './modules/instance_counter'

class Route
  attr_reader :route
  attr_writer :train_position
  @@routes = []

  def initialize(station_start, station_end)
    @route = [station_start, station_end]
    @@routes << self
    @train_position = 0
  end

  def add_station(station)
    @route.insert(1, station)
  end

  def delete_station(station)
    @route.delete(station)
  end

  def station_last
    @route[@train_position - 1] if @train_position - 1 >= 0
    'Вы на первой станции.'
  end

  def station_next
    @route[@train_position + 1] if @train_position + 1 <= @route.size - 1
    'Вы на последней станции.'
  end

  def station_now
    @route[@train_position]
  end

  def route_size
    @route.size
  end

  def self.all
    @@routes
  end
end
