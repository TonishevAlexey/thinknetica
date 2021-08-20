require_relative '../car/car'
require_relative '../car/cargo_car'
require_relative '../train/train'
require_relative '../car/passenger_car'
require_relative '../train/cargo_train'
require_relative '../train/passenger_train'
require_relative '../route'
require_relative '../station'

module Interface
  def run_back
    begin
      @n_t = 0
      puts 'Выберете поезд который хотите отправить на предыдущую станцию:'
      Train.all.each do |s|
        puts "Для выбора #{s.number} введите #{@n_t}"
        @n_t += 1
      end
      station = Train.all[gets.chomp.to_i]
      station.go_back
    rescue StandardError => e
      puts e
    end
  end

  def run_car
    begin
      @n_t = 0
      puts 'Выберете поезд который хотите отправить на следующую станцию:'
      Train.all.each do |s|
        puts "Для выбора #{s.number} введите #{@n_t}"
        @n_t += 1
      end
      station = Train.all[gets.chomp.to_i]
      station.go_next
    rescue StandardError => e
      puts e
    end
  end

  def delete_c
    begin
      @n_t = 0
      puts 'Выберете поезд у которого хотите удалить вагон:'
      Train.all.each do |s|
        puts "Для выбора #{s.number} введите #{@n_t}"
        @n_t += 1
      end
      trains = gets.chomp.to_i
      Train.all[trains].delete_car
    rescue StandardError => e
      e
    end
  end

  def create_s
    begin
      print 'Введите название станции в формате (на русском не менее 3 и не более 10 букв):'
      name_station = gets.chomp
      Station.new(name_station)
    rescue StandardError => e
      puts e
      retry
    end
  end

  def create_t
    begin
      print 'Введите номер поезда в формате (ww-www или wwwww) : '
      number_train = gets.chomp
      print 'Введите тип поезда(пассажирский-п или грузовой-г):'
      type_train = gets.chomp
      if type_train == 'г'
        CargoTrain.new(number_train)
      elsif type_train == 'п'
        PassengerTrain.new(number_train)
      else
        raise 'Неверный тип поезда'
      end
    rescue StandardError => e
      puts e
      retry
    end
  end

  def create_r
    puts 'Маршрут.Выберете начальную станцию'
    Station.all.each_with_index do |s, i|
      puts "Для выбора: #{s.name} введите #{i}"
    end
    start_station = gets.chomp.to_i
    puts 'Маршрут.Выберете конечную станцию станцию:'
    Station.all.each_with_index do |s, i|
      puts "Для выбора: #{s.name} введите #{i}" if start_station != i
    end
    end_station = gets.chomp.to_i
    Route.new(Station.all[start_station], Station.all[end_station])
    if Station.all.size > 2
      puts 'Маршрут.Выберете какую станцию добавить:'
      Station.all.each_with_index do |s, i|
        puts "Для выбора #{s.name} введите #{i}" if start_station != i && end_station != i
      end
      add_station = gets.chomp.to_i
      Route.all[Route.all.size - 1].add_station(Station.all[add_station])
    end
  end

  def add_r
    @n_t = 0
    puts 'Выберете поезд к котрому хотите добавить маршрут:'
    Train.all.each do |s|
      puts "Для выбора #{s.number} введите #{@n_t}"
      @n_t += 1
    end
    trains = gets.chomp.to_i
    @n_t = 0
    puts 'Выберете  маршрут:'
    Route.all.each do |s|
      puts "Для выбора #{s} введите #{@n_t}"
      @n_t += 1
    end
    route = gets.chomp.to_i
    Train.all[trains].assign_route(Route.all[route])
  end

  def add_c
    begin
      @n_t = 0
      puts 'Выберете поезд к которому хотите добавить вагон:'
      Train.all.each do |s|
        puts "Для выбора #{s.number} введите #{@n_t}"
        @n_t += 1
      end
      trains = gets.chomp.to_i
      puts 'Введите количество мест вагона:' if Train.all[trains].class == PassengerTrain
      puts 'Введите объем вагона:' if Train.all[trains].class == CargoTrain
      places = gets.chomp.to_i
      Train.all[trains].add_car(places)
    rescue StandardError => e
      puts e
      retry
    end
  end

  def train_cars
    puts 'Выберете поезд к которого хотите посмотреть вагоны.'
    Train.all.each_with_index { |sta, i| puts "#{sta.number}:#{i}" }
    num = gets.chomp.to_i
    Train.all[num].all_cars_block { |arr| puts "Свободных:#{arr.places - arr.busy_places}.Занятых:#{arr.busy_places}" }
  end

  def station_trains
    puts 'Выберете станцию на которой хотите посмотреть поезда.'
    Station.all.each_with_index { |sta, i| puts "#{sta.name}:#{i}" }
    num = gets.chomp.to_i
    Station.all[num].all_train_block { |arr| puts "Номер:#{arr.number}\nТип:#{arr.class::TYPE}\nКол-во вагонов:#{arr.number_cars.size}\n" }
  end

  def station_all
    Station.all
  end

  def place
    trains = Train.all
    puts 'Выберете поезд к которого хотите посмотреть вагоны.'
    trains.each_with_index { |sta, i| puts "#{sta.number}:#{i}" }
    num = gets.chomp.to_i
    train = trains[num]
    puts 'Выберете вагон в котором хотите занять место.' if ps_train?(num)
    puts 'Выберете вагон в котором хотите занять объем.' if ca_train?(num)
    train.all_cars_block { |arr| puts "Свободных:#{arr.places - arr.busy_places}.Занятых:#{arr.busy_places}" }
    num = gets.chomp.to_i
    car = train.number_cars[num]
    car.take_places if ps_train?(num)
    if ca_train?(num)
      puts 'Введите занимаемый объем:'
      num = gets.chomp.to_i
      car.take_places num
    end

  end

  private

  def ps_train?(trains)
    Train.all[trains].class == PassengerTrain
  end

  def ca_train?(trains)
    Train.all[trains].class == CargoTrain
  end
end
