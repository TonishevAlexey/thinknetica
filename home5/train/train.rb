require_relative '../modules/company'
require_relative '../modules/instance_counter'


class Train
  extend Company
  include InstanceCounter
  @@train_all = []
  # Может набирать скорость speed(),Может возвращать текущую скорость speed
  attr_accessor :speed;
  attr_reader :number_cars, :number;
  #   Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
  def initialize(number)
    @number = number
    @number_cars = []
    @speed = 0
    @route
    @current_station_index = 0
    @@train_all << self
    self.register_instance
  end

  # Исправлено, Может тормозить (сбрасывать скорость до нуля) stop
  def stop
    self.speed(0)
  end

  #При добавлении маршрута поезд должен добавляться на станцию отправления , прописана в условиях задания,Может принимать маршрут следования (объект класса Route).
  def assign_route(route)
    @route = route
    @route.station_now.add_trains(self)
  end

  #   Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
  #Следующая станция , прописана в условиях задания, run_trains это движение поезда по маршруту , т.е удаление с предведущей станции и добавление на новой
  def go_next
    if @current_station_index < ((@route.route_size) - 1)
      @route.station_now.run_trains(@route.station_next, self)
      @current_station_index += 1
      current_station_index
    else
      puts "Вы на последней станции."
    end
  end

  #   Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
  def go_back
    if @current_station_index > 0
      @route.station_now.run_trains(@route.station_last, self)
      @current_station_index -= 1
      current_station_index
    else
      puts "Вы на первой станции."
    end
  end

  #   Возвращать предыдущую станцию, текущую, следующую, на основе маршрута , прописана в условиях задания
  def station_last
    @route.station_last
  end

  #   Возвращать предыдущую станцию, текущую, следующую, на основе маршрута , прописана в условиях задания
  def station_next
    @route.station_next
  end

  #   Возвращать предыдущую станцию, текущую, следующую, на основе маршрута , прописана в условиях задания
  def station_now
    @route.station_now
  end

  def add_car(type)
    if stop? && type?
      @number_cars << type
    else
      error
    end
  end

  #  Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.

  def delete_car
    @number_cars.last.delete if stop? && @number_cars.size > 1
    puts "Поезд находиться в движении или остался всего 1"
  end

  def self.find(attr)
    f = @@train_all.select { |t| t.number == attr }
    if f.empty?
      'nil'
    else
      f
    end

  end

  private

  def error
    puts "Неправельный тип вагона"
  end

  def stop?
    self.speed == 0
  end

  def type?
    self.class == type.class.to_s
  end

  def current_station_index
    @route.train_position = @current_station_index

  end
end

a = Train.new(1)
a2 = Train.new(1)
a3 = Train.new(3)
puts Train.find(7)
puts Train.find(1)
puts Train.instances
puts a.instances
puts a.instances
puts a.instances

