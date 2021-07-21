list={}
sum=0
loop do
  print"Название товара:"
  name_p=gets.chomp
  break if name_p=="стоп"
  print"Цена:"
  price=gets.chomp.to_i
  print"Количество:"
  quantity=gets.chomp.to_i
  list[name_p]={p:price,q:quantity}
  sum+=price*quantity
  puts "Итого: #{price*quantity}"
  puts list
end
puts "Общая стоимость: #{sum}"