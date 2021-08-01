require_relative '../modules/company'
require_relative '../modules/instance_counter'

class Train
  extend Company
  include InstanceCounter
  @@train_all = []
  attr_accessor :speed
  attr_reader :number_cars, :number

  NUMBER_FORMAT = /^(\w|[а-я]){2}(-?)(\w|[а-я]){3}$/i

  def initialize(number)
    @number = number
    @number_cars = []
    @speed = 0
    @route
    @current_station_index = 0
    validate!
    @@train_all << self
    self.register_instance
  end

  def stop
    self.speed(0)
  end

  def assign_route(route)
    @route = route
    @route.station_now.add_trains(self)
  end

  def go_next
    raise "Вы на первой станции" unless @current_station_index < ((@route.route_size) - 1)
    @route.station_now.run_trains(@route.station_next, self)
    @current_station_index += 1
    current_station_index
  end

  def go_back
    raise "Вы на первой станции" unless @current_station_index > 0
    @route.station_now.run_trains(@route.station_last, self)
    @current_station_index -= 1
    current_station_index

  end

  def station_last
    @route.station_last
  end

  def station_next
    @route.station_next
  end

  def station_now
    @route.station_now
  end

  def add_car(type)
    validate!
    @number_cars << type

  end

  def delete_car
    raise "Поезд находиться в движении или остался всего 1" unless stop? && @number_cars.size > 1
    @number_cars.last.delete
  end

  def self.find(attr)
    f = @@train_all.select { |t| t.number == attr }
    if f.empty?
      'nil'
    else
      f
    end

  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    errors = []
    errors << "Неверный формат номера" unless number.to_s =~ NUMBER_FORMAT
    errors << "Неправельный тип вагона или скорость больше 0" unless stop? && type?
    raise errors.join(" ") unless errors.empty?
  end

  def stop?
    self.speed == 0
  end

  def type?
    self.class == type.class
  end

  def current_station_index
    @route.train_position = @current_station_index

  end
end
