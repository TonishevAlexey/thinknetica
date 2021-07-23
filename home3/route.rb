# Класс Route (Маршрут):
#   Имеет начальную и конечную станцию, а также список промежуточных станций.
# Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
#   Может добавлять промежуточную станцию в список
# Может удалять промежуточную станцию из списка
# Может выводить список всех станций по-порядку от начальной до конечной
class Route
  attr_reader :route;
  def initialize(station_start,station_end)
    @route = [station_start,station_end]
  end
  def  add_station(station)
    @route.insert(1,station)
  end
  def  delete_station(station)
    @route.delete(station)
  end
  def  routes
    # route_str = []
    # route.each { |station| route_str<<station.name}
    # puts  "Маршрут:#{route_str.join(', ').gsub(","," ->")}"
     puts @route
  end
end
