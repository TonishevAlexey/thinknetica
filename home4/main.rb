require_relative 'cargo_cars'
require_relative 'train'
require_relative 'passenger_cars'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'route'
require_relative 'station'

class Main
  @@station = []
  @@trains = []
  @@route = 0

  def create_station
    create_s
  end

  def create_train
    create_t
  end

  def create_route
    create_r
  end

  def add_route
    add_r
  end

  def add_car
    add_c
  end

  def delete_car
    delete_c
  end

  def go_next
    run_car
  end

  def go_back
    run_back
  end

  private

  def run_back
    @n_t = 0
    puts "Выберете поезд который хотите отправить на предыдущую станцию:"
    @@trains.each do |s|
      puts "Для выбора #{s.number} введите #{@n_t}"
      @n_t += 1
    end
    station = @@trains[gets.chomp.to_i]
    station.go_back
  end

  def run_car
    @n_t = 0
    puts "Выберете поезд который хотите отправить на следующую станцию:"
    @@trains.each do |s|
      puts "Для выбора #{s.number} введите #{@n_t}"
      @n_t += 1
    end
    station = @@trains[gets.chomp.to_i]
    station.go_next
  end

  def delete_c
    @n_t = 0
    puts "Выберете поезд у которо хотит удалить вагон:"
    @@trains.each do |s|
      puts "Для выбора #{s.number} введите #{@n_t}"
      @n_t += 1
    end
    trains = gets.chomp.to_i
    @@trains[trains].delete_car
  end

  def create_s
    @n = 0
    loop do
      print "Введите название станции(Для окончаеия создания станций введите(если их больше двух)stop):"
      name_station = gets.chomp
      @n += 1
      break if name_station == 'stop' && @n >= 2
      @@station << Station.new(name_station)
    end
  end

  def create_t
    loop do
      print "Введите номер поезда(Для окончаеия создания поездов введите stop): "
      number_train = gets.chomp
      break if number_train == 'stop'
      print "Введите тип поезда(пассажирский или грузавой):"
      type_train = gets.chomp
      if type_train == 'пассажирский'
        @@trains << CargoTrain.new(number_train)
      else
        @@trains << PassengerTrain.new(number_train)
      end
    end
  end

  def create_r
    @n_s = 0
    puts "Маршрут.Выберете начальную станцию"
    @@station.each do |s|
      puts "Для выбора: #{s.name} введите #{@n_s}"
      @n_s += 1
    end
    start_station = gets.chomp.to_i
    @n_s = 0
    puts "Маршрут.Выберете конечную станцию станцию:"
    @@station.each do |s|
      puts "Для выбора: #{s.name} введите #{@n_s}" if start_station != @n_s
      @n_s += 1
    end
    end_station = gets.chomp.to_i
    @@route = Route.new(@@station[start_station], @@station[end_station])
    @n_s = 0
    puts "Маршрут.Выберете какую станцию добавить:"
    @@station.each do |s|
      puts "Для выбора #{s.name} введите #{@n_s}" if start_station != @n_s && end_station != @n_s
      @n_s += 1
    end
    add_station = gets.chomp.to_i
    @@route.add_station(@@station[add_station])
  end

  def add_r
    @n_t = 0
    puts "Выберете поезд к котрому хотите добавить маршрут:"
    @@trains.each do |s|
      puts "Для выбора #{s.number} введите #{@n_t}"
      @n_t += 1
    end
    trains = gets.chomp.to_i
    @@trains[trains].assign_route(@@route)

  end

  def add_c
    trains = gets.chomp.to_i
    @@trains[trains].assign_route(@@route)
    @n_t = 0
    puts "Выберете поезд к коророму хотите добавить вагон:"
    @@trains.each do |s|
      puts "Для выбора #{s.number} введите #{@n_t}"
      @n_t += 1
    end
    trains = gets.chomp.to_i
    if 'PassengerCars' == trains.class.to_s
      @@trains[trains].add_car
    elsif 'CargoCars' == trains.class.to_s
      @@trains[trains].add_car
    end
  end
end

m = Main.new
m.create_station
m.create_train
m.create_route
m.add_route
m.add_car
m.delete_car
m.go_next
m.go_back
