array=[0,1]
i=0
while i<120
  array<<array[i]+array[i+1]
  i+=1
end
puts array