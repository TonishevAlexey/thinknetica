all=[*('a'..'z')]
vowels={}
all.size.times do | i |
  vowels[all[i-1]]=i if 'aeiou'.include?(all[i-1])
end
puts vowels