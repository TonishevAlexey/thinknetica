require_relative '../modules/company'
require_relative '../modules/instance_counter'

class Train
  extend Company
  include InstanceCounter
  @@train= []
  attr_accessor :speed
  attr_reader :number_cars, :number

  NUMBER_FORMAT = /^(\w|[а-я]){2}(-?)(\w|[а-я]){3}$/i

  def initialize(number)
    @number = number
    @number_cars = []
    @speed = 0
    @route
    @current_station_index = 1
    validate!
    @@train << self
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
    raise "Вы на первой станции" if @current_station_index == 1
    @route.station_now.run_trains(@route.station_next, self)
    @current_station_index += 1
    current_station_index
  end

  def go_back
    raise "Вы на первой станции" unless @current_station_index == @route.route_size
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

  def delete_car
    raise "Поезд находиться в движении или остался всего 1" unless stop? && @number_cars.size > 1
    @number_cars.last.delete
  end

  def self.find(attr)
    f = @@train.select { |t| t.number == attr }
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
  def self.all
    @@train
  end
  def all_cars_block (&block)
    number_cars.each_with_index do |car,i| print "Номер вагона:#{i+1}:"
    puts "#{block.call(car)}"
    end
  end
  protected

  def validate!
    errors = []
    errors << "Неверный формат номера" unless number.to_s =~ NUMBER_FORMAT
    errors << "Неправельный поезд находиться в двежении" unless stop?
    raise errors.join(" ") unless errors.empty?
  end

  def stop?
    self.speed == 0
  end

  def current_station_index
    @route.train_position = @current_station_index

  end
end
