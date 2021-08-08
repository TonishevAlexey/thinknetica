require_relative 'interface/interface'

class Main
  extend Interface
  puts "w-буква или цифра,d-цифра."

  def initialize
    @station = []
    @trains = []
    @route = 0

  end

  loop do
    puts "Введиет 1 для создания станции"
    puts "Введиет 2 для создания поезда"
    puts "Введиет 3 для создания маршрута" if Station.all.size >1
    puts "Введиет 4 для добавления маршрута "if Route.all.size >0
    puts "Введиет 5 для добавления вагона"if Train.all.size >0
    puts "Введиет 6 для удаления вагона"if Train.all.size >0
    puts "Введиет 7 для передвижения поезда на следующую станцию"if Route.all.size >0
    puts "Введиет 8 для передвижения поезда на предыдущую станцию"if Route.all.size >0
    puts "Введиет 9 для просмотра всех станций"if Station.all.size >0
    puts "Введиет 10 для просмотра поездов на станции"if Train.all.size >0
    puts "Введиет 11 для просмотра вагонов в поезде"if Train.all.size >0
    puts "Введиет 12 для управлением вагоном"if Train.all.size >0
    number = gets.chomp.to_i
    case number
    when 1
      self.create_s
    when 2
      self.create_t
    when 3
      self.create_r
    when 4
      self.add_r
    when 5
      self.add_c
    when 6
      self.delete_c
    when 7
      self.run_car
    when 8
      self.run_back
    when 9
      puts self.station_all
    when 10
      self.station_trains
    when 11
      self.train_cars
    when 12
      self.place
    else
      break
    end
  end
end

m = Main.new

