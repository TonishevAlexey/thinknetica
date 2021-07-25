require_relative 'cargo_cars'
require_relative 'train'
require_relative 'passenger_cars'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'route'
require_relative 'station'

class Main
  @n = 0
  @station = []
  loop do
    print "Введите название станции: "
    name_station = gets.chomp
    @station << Station.new(name_station)
    @n += 1
    print "Для окончаеия создания станций введите(если их больше двух)stop если хотите продолжить нажмите enter:"
    break if gets.chomp == 'stop' && @n >= 2
  end
  @trains = []
  loop do
    print "Введите номер поезда: "
    number_train = gets.chomp
    print "Введите тип поезда(пассажирский или грузавой): "
    type_train = gets.chomp
    if type_train == 'пассажирский'
      @trains << CargoTrain.new(number_train)
    else
      @trains << PassengerTrain.new(number_train)
    end
    print "Для окончаеия создания поездов введите stop если хотите продолжить нажмите enter:"
    break if gets.chomp == 'stop'
  end

  @n_s = 0
  puts "Маршрут.Выберете начальную станцию"
  @station.each do |s|
    puts "Для выбора: #{s.name} введите #{@n_s}"
    @n_s += 1
  end
  start_station = gets.chomp.to_i
  @n_s = 0
  puts "Маршрут.Выберете конечную станцию станцию:"
  @station.each do |s|
    puts "Для выбора: #{s.name} введите #{@n_s}" if start_station != @n_s
    @n_s += 1
  end
  end_station = gets.chomp.to_i
  @route = Route.new(@station[start_station], @station[end_station])
  @n_s = 0
  puts "Маршрут.Выберете какую станцию добавить:"
  @station.each do |s|
    puts "Для выбора #{s.name} введите #{@n_s}" if start_station != @n_s && end_station != @n_s
    @n_s += 1
  end
  add_station = gets.chomp.to_i
  @route.add_station(@station[add_station])
  @n_t = 0
  puts "Выберете поезд к котрому хотите добавить маршрут:"
  @trains.each do |s|
    puts "Для выбора #{s.number} введите #{@n_t}"
    @n_t += 1
  end
  trains = gets.chomp.to_i
  @trains[trains].assign_route(@route)
  @n_t = 0
  puts "Выберете поезд к коророму хотите добавить вагон:"
  @trains.each do |s|
    puts "Для выбора #{s.number} введите #{@n_t}"
    @n_t += 1
  end
  trains = gets.chomp.to_i
  if 'PassengerCars' == trains.class.to_s
    @trains[trains].add_car
  elsif 'CargoCars' == trains.class.to_s
    @trains[trains].add_car
  end
  @n_t = 0
  puts "Выберете поезд у которо хотит удалить вагон:"
  @trains.each do |s|
    puts "Для выбора #{s.number} введите #{@n_t}"
    @n_t += 1
  end
  trains = gets.chomp.to_i
  @trains[trains].delete_car
  @n_t = 0
  puts "Выберете поезд который хотите отправить на следующую станцию:"
  @trains.each do |s|
    puts "Для выбора #{s.number} введите #{@n_t}"
    @n_t += 1
  end
  station = @trains[gets.chomp.to_i]
  station.go_next
  @n_t = 0
  puts "Выберете поезд который хотите отправить на предыдущую станцию:"
  @trains.each do |s|
    puts "Для выбора #{s.number} введите #{@n_t}"
    @n_t += 1
  end
  station = @trains[gets.chomp.to_i]
  station.go_back
end

Main.new