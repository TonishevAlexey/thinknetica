# Класс Route (Маршрут):
#   Имеет начальную и конечную станцию, а также список промежуточных станций.
# Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
#   Может добавлять промежуточную станцию в список
# Может удалять промежуточную станцию из списка
# Может выводить список всех станций по-порядку от начальной до конечной
class Route
  # Исправлено.Может выводить список всех станций по-порядку от начальной до конечной
  attr_reader :route
  attr_writer :train_position
  #   Имеет начальную и конечную станцию, а также список промежуточных станций.
  def initialize(station_start, station_end)
    @route = [station_start, station_end]
    @train_position = 0
  end

  #   Может добавлять промежуточную станцию в список
  def add_station(station)
    @route.insert(1, station)
  end

  # Может удалять промежуточную станцию из списка
  def delete_station(station)
    @route.delete(station)
  end

  def station_last
    return @route[@train_position - 1] if @train_position - 1 >= 0
    "Вы на первой станции."
  end

  #   Возвращать предыдущую станцию, текущую, следующую, на основе маршрута , прописана в условиях задания
  def station_next
    return  @route[@train_position + 1] if @train_position + 1 <= @route.size - 1
    "Вы на последней станции."
  end

  #   Возвращать предыдущую станцию, текущую, следующую, на основе маршрута , прописана в условиях задания
  def station_now
    @route[@train_position]
  end
  def route_size
    @route.size
  end
end
