month_h = {
  January: 1,
  February: 2,
  March: 3,
  April: 4,
  May: 5,
  June: 6,
  Jule: 7,
  August: 8,
  September: 9,
  October: 10,
  November: 11,
  December: 12

}

print "Введите  день:"
day = gets.chomp.to_i
print "Введите  месяц(1-12или на английском):"
month = gets.chomp
print "Введите  год:"
year = gets.chomp.to_i
month_day = [31, 28, 31, 30, 31, 30, 31,31, 30,31, 30, 31]
month_day[1]=29if(year%4==0&&year%100!=0)||year%400==0
sum=0
i=0
if month.length < 3
  while i<month.to_i-1
    sum+= month_day[i]
    i+=1
  end
  puts sum+day
else
  while i< month_h[month.to_sym].to_i-1
    sum+= month_day[i]
    i+=1
  end
  puts sum+day
end
