# Класс Train (Поезд):
#   Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса +
# Может набирать скорость speed()
# Может возвращать текущую скорость speed
# Может тормозить (сбрасывать скорость до нуля) stop
# Может возвращать количество вагонов number_cars
# add_car,delete_car Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
#   Может принимать маршрут следования (объект класса Route).
#     При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
#   Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
#   Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
class Train
  attr_accessor :speed;
  attr_reader :number_cars;

  def initialize(number, type, number_cars)
    @number = number
    @type = type
    @number_cars = number_cars
    @speed = 0
    @route
    @station = 0
  end

  def stop
    speed(0)
  end

  def add_car
    @number_cars += 1 if speed == 0
  end

  def delete_car
    @number_cars -= 1 if speed == 0
  end

  def route(route)
    @route = route
    @route[@station].add_trains(self)
  end

  def run
    @route[@station].run_trains(@route[0 + 1], self)
    @station += 1
  end

  def back
    @route[@station].run_trains(@route[0 - 1], self)
    @station -= 1
  end

  def station_last
    return @route[@station - 1] if @station - 1 >= 0
    return "Отсутствует"
  end

  def station_next
    return @route[@station + 1] if @station + 1 <= (@route.size -1)
    return "Отсутствует"
  end

  def station_now
    return @route[@station]
  end

end