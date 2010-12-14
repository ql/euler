#!/usr/bin/ruby
require 'euler_helper.rb'

def mandatory_penta n1, n2
  int(Math.sqrt(1+ (n1-n2) * 24)) && int(Math.sqrt(1+ (n1+n2) * 24))
end

def pentagonal? n
  return false unless n > 0
  i = (1 + Math.sqrt(1 + 24 * n)) / 6
  return i if i.to_i == i
  nil
end

def hexagonal? n
  return false unless n > 0
  i = (1 + Math.sqrt(1 + 8 * n)) / 4
  return i if i.to_i == i
  nil
end

def triangle i
  #$h2[i] ? $h2[i] : $h2[i] = (i*(i*3 - 1) >> 1)
  i*(i + 1) >> 1
end

def int i
 i.to_i == i
end


limit = 400
h = {}
$h2 ={}
#benchmark do
#  for j in 1..(limit ** 2 / 2) do
#    h[penta(j)]=1
#  end
#  puts 'initialized'
#end
j = 287
while true
  if pentagonal?(triangle(j)) && hexagonal?(triangle(j))
    puts j 
    puts triangle(j)
    break
  end
  j += 1
end
