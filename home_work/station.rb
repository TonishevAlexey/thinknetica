require_relative './modules/instance_counter'

class Station
  attr_reader :trains, :name
  @@stations = []
  NAME_FORMAT = /^[а-я]{3,10}$/i.freeze

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
  end

  def add_trains(train)
    @trains << train.number
  end

  def run_trains(station, train)
    station.add_trains(train)
    @trains.delete(train)
  end

  def trains_type(type)
    n = []
    @trains.each { |train| n << @trains if train.class == type.class }
    n
  end

  def self.all
    @@stations
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def all_train_block(&block)
    trains.each { |train| block.call(train) }
  end

  private

  def validate!
    errors = []
    errors << 'Неверный формат названия станции' unless name =~ NAME_FORMAT
    raise errors.join(' ') unless errors.empty?
  end
end
