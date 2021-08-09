require_relative './modules/instance_counter'

class Station
  attr_reader :trains, :name
  @@station = []
  NAME_FORMAT = /^[а-я]{3,10}$/i

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@station << self
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
    @@station
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def all_train_block (&block)
    trains.each { |train|  block.call(train)}
  end

  private

  def validate!
    errors = []
    errors << "Неверный формат названия станции" unless name =~ NAME_FORMAT
    raise errors.join(" ") unless errors.empty?
  end

end
