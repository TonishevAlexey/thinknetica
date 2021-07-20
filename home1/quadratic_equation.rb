print "Введите коэффициент 1:"
k1 = gets.chomp.to_i
print "Введите коэффициент 2:"
k2 = gets.chomp.to_i
print "Введите коэффициент 3:"
k3 = gets.chomp.to_i
d = (k2 ** 2 - 4 * k1 * k3)
if d < 0
  puts "D=#{d}\nКорней нет"
elsif d == 0
  x = -k2/(2*k1)
  puts "D=#{d}\nx=#{x}"
elsif d > 0
  c = Math.sqrt(d)
  x1=(-k2+c)/(2*k1)
  x2=(-k2-c)/(2*k1)
  puts "#D={d}\nx1=#{x1}\nx2=#{x2}"
end
