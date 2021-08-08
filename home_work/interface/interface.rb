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
      puts "Выберете поезд который хотите отправить на предыдущую станцию:"
      @trains.each do |s|
        puts "Для выбора #{s.number} введите #{@n_t}"
        @n_t += 1
      end
      station = @trains[gets.chomp.to_i]
      station.go_back
    rescue => e
      puts e
    end
  end

  def run_car
    begin
      @n_t = 0
      puts "Выберете поезд который хотите отправить на следующую станцию:"
      @trains.each do |s|
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
      @trains.each do |s|
        puts "Для выбора #{s.number} введите #{@n_t}"
        @n_t += 1
      end
      trains = gets.chomp.to_i
      @trains[trains].delete_car
    rescue => e
      e
    end
  end

  def create_s
    begin
      print "Введите название станции в формате (на русском не менее 3 и не более 10 букв):"
      name_station = gets.chomp
      Station.new(name_station)
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
      if type_train == 'г'
        CargoTrain.new(number_train)
      elsif type_train == 'п'
        PassengerTrain.new(number_train)
      else
        raise "Неверный тип поезда"
      end
    rescue => e
      puts e
      retry
    end
  end

  def create_r
    puts "Маршрут.Выберете начальную станцию"
    Station.all.each_with_index do |s, i|
      puts "Для выбора: #{s.name} введите #{i}"
    end
    start_station = gets.chomp.to_i
    puts "Маршрут.Выберете конечную станцию станцию:"
    Station.all.each_with_index do |s, i|
      puts "Для выбора: #{s.name} введите #{i}" if start_station != i
    end
    end_station = gets.chomp.to_i
    @route = Route.new(@station[start_station], @station[end_station])
    if Station.all.size > 2
      puts "Маршрут.Выберете какую станцию добавить:"
      Station.all.each_with_index do |s, i|
        puts "Для выбора #{s.name} введите #{i}" if start_station != i && end_station != i
      end
      add_station = gets.chomp.to_i
      @route.add_station(@station[add_station])
    end
  end

  def add_r
    @n_t = 0
    puts "Выберете поезд к котрому хотите добавить маршрут:"
    @trains.each do |s|
      puts "Для выбора #{s.number} введите #{@n_t}"
      @n_t += 1
    end
    trains = gets.chomp.to_i
    @trains[trains].assign_route(@route)

  end

  def add_c
    begin
      @n_t = 0
      puts "Выберете поезд к коророму хотите добавить вагон:"
      Train.all.each do |s|
        puts "Для выбора #{s.number} введите #{@n_t}"
        @n_t += 1
      end
      trains = gets.chomp.to_i
      puts "Введите количество мест вагона:" if Train.all[trains].class == PassengerTrain
      puts "Введите объем вагона:" if Train.all[trains].class == CargoTrain
      places = gets.chomp.to_i
      Train.all[trains].add_car(places)
    rescue => e
      puts e
      retry
    end
  end

  def train_cars
    puts "Выберете поезд к которого хотите посмотреть вагоны."
    Train.all.each_with_index { |sta, i| puts "#{sta.number}:#{i}" }
    num = gets.chomp.to_i
    Train.all[num].all_cars_block { |arr| puts "Свободных:#{arr.places - arr.busy}.Занятых:#{arr.busy}" }

  end

  def station_trains
    puts "Выберете станцию на которой хотите посмотреть поезда."
    Station.all.each_with_index { |sta, i| puts "#{sta.name}:#{i}" }
    num = gets.chomp.to_i
    Station.all[num].all_train_block { |arr| puts "Номер:#{arr.number}\nТип:#{arr.type}\nКол-во вагонов:#{arr.number_cars.size}\n" }
  end

  def station_all
    Station.all
  end

  def place
    trains = Train.all
    puts "Выберете поезд к которого хотите посмотреть вагоны."
    trains.each_with_index { |sta, i| puts "#{sta.number}:#{i}" }
    num = gets.chomp.to_i
    train = trains[num]
    puts "Выберете вагон в котором хотите занять место." if ps_train?
    puts "Выберете вагон в котором хотите занять объем." if ca_train?
    train.all_cars_block { |arr| puts "Свободных:#{arr.places - arr.busy}.Занятых:#{arr.busy}" }
    num = gets.chomp.to_i
    car = train.number_cars[num]
    car.take_places if ps_train?
    if ca_train?
      puts "Введите занимаемый объем:"
      num = gets.chomp.to_i
      car.busy = num
    end

  end

  private

  def ps_train?
    Train.all[trains].class == PassengerTrain
  end

  def ca_train?
    Train.all[trains].class == CargoTrain
  end
end
