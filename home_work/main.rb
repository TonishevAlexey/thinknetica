require_relative 'interface/interface'

class Main
  extend Interface
  puts 'w-буква или цифра,d-цифра.'

  loop do
    puts 'Введиет 1 для создания станции'
    puts 'Введиет 2 для создания поезда'
    puts 'Введиет 3 для создания маршрута' if Station.all.size > 1
    puts 'Введиет 4 для добавления маршрута ' unless Route.all.empty?
    puts 'Введиет 5 для добавления вагона' unless Train.all.empty?
    puts 'Введиет 6 для удаления вагона' unless Train.all.empty?
    puts 'Введиет 7 для передвижения поезда на следующую станцию' unless Route.all.empty?
    puts 'Введиет 8 для передвижения поезда на предыдущую станцию' unless Route.all.empty?
    puts 'Введиет 9 для просмотра всех станций' unless Station.all.empty?
    puts 'Введиет 10 для просмотра поездов на станции' unless Train.all.empty?
    puts 'Введиет 11 для просмотра вагонов в поезде' unless Train.all.empty?
    puts 'Введиет 12 для управлением вагоном' unless Train.all.empty?
    number = gets.chomp.to_i
    case number
    when 1
      create_s
    when 2
      create_t
    when 3
      create_r
    when 4
      add_r
    when 5
      add_c
    when 6
      delete_c
    when 7
      run_car
    when 8
      run_back
    when 9
      puts station_all.map { |s| s.name }
    when 10
      station_trains
    when 11
      train_cars
    when 12
      place
    else
      break
    end
  end
end
