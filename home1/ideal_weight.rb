# Идеальный вес. Программа запрашивает у пользователя имя и рост и выводит идеальный вес по формуле (<рост> - 110) * 1.15,
# после чего выводит результат пользователю на экран с обращением по имени. Если идеальный вес получается отрицательным,
# то выводится строка "Ваш вес уже оптимальный"
print "Введите свое имя:"
name=gets.chomp
print "Введите свой рост:"
height=gets.chomp.to_i
ideal_weight=(height-110)*1.15
if ideal_weight<0
  puts "#{name},ваш вес уже оптимальный"
else
  puts "#{name},ваш оптимальный вес:#{ideal_weight.to_i}"
end