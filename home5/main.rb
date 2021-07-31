require_relative 'car/car'
require_relative 'car/cargo_car'
require_relative 'train/train'
require_relative 'car/passenger_car'
require_relative 'train/cargo_train'
require_relative 'train/passenger_train'
require_relative 'route'
require_relative 'station'

class Main
  @@station = []
  @@trains = []
  @@route = 0
  puts "w-буква или цифра,d-цифра."

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
    begin
      @n_t = 0
      puts "Выберете поезд который хотите отправить на предыдущую станцию:"
      @@trains.each do |s|
        puts "Для выбора #{s.number} введите #{@n_t}"
        @n_t += 1
      end
      station = @@trains[gets.chomp.to_i]
      station.go_back
    rescue => e
      puts e
    end
  end

  def run_car
    begin
      @n_t = 0
      puts "Выберете поезд который хотите отправить на следующую станцию:"
      @@trains.each do |s|
        puts "Для выбора #{s.number} введите #{@n_t}"
        @n_t += 1
      end
      station = @trains[gets.chomp.to_i]
      station.go_next
    rescue => e
      puts e
    end
  end

  def delete_c
    begin
      @n_t = 0
      puts "Выберете поезд у которо хотит удалить вагон:"
      @@trains.each do |s|
        puts "Для выбора #{s.number} введите #{@n_t}"
        @n_t += 1
      end
      trains = gets.chomp.to_i
      @@trains[trains].delete_car
    rescue => e
      e
    end
  end

  def create_s
    begin
      print "Введите название станции в формате (на русском не менее 3 и не более 10 букв):"
      name_station = gets.chomp
      @@station << Station.new(name_station)
    rescue => e
      puts e
      retry
    end
  end

  def create_t
    begin
      print "Введите номер поезда в формате (ww-www или wwwww) : "
      number_train = gets.chomp
      print "Введите тип поезда(пассажирский-п или грузовой-г):"
      type_train = gets.chomp
      if type_train == 'п'
        @@trains << CargoTrain.new(number_train)
      elsif type_train == 'г'
        @@trains << PassengerTrain.new(number_train)
      else
        raise "Неверный тип поезда"
      end
    rescue => e
      puts e
      retry
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
    begin
      trains = gets.chomp.to_i
      @@trains[trains].assign_route(@@route)
      @n_t = 0
      puts "Выберете поезд к коророму хотите добавить вагон:"
      @@trains.each do |s|
        puts "Для выбора #{s.number} введите #{@n_t}"
        @n_t += 1
      end
      trains = gets.chomp.to_i
      @@trains[trains].add_car
    rescue => e
      puts e
      retry
    end
  end

end

m = Main.new
# m.create_station
m.create_train
# m.create_route
# m.add_route
# m.add_car
# m.delete_car
# m.go_next
# m.go_back
