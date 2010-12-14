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

def penta i
  #$h2[i] ? $h2[i] : $h2[i] = (i*(i*3 - 1) >> 1)
  (i*(i*3 - 1) >> 1)
end

def int i
 i.to_i == i
end


limit = 1000000
h = {}
$h2 ={}
#benchmark do
#  for j in 1..(limit ** 2 / 2) do
#    h[penta(j)]=1
#  end
#  puts 'initialized'
#end

benchmark do
  for j in 1..limit do
    for k in j..limit do
      #p1 = penta(j)
      #p2 = penta(k)
      #puts [j,k].inspect if pentagonal?(p1+p2) && pentagonal?(p2-p1)
      puts [j,k].inspect if mandatory_penta(penta(k),penta(j)) && pentagonal?(penta(k) - penta(j)) && pentagonal?(penta(k) + penta(j)) 
      if false && h[$h2[j]+$h2[k]] && h[$h2[k]-$h2[j]]
        puts [j,k].inspect 
        puts $h2[j]
        puts $h2[k]
        puts pentagonal?($h2[j]+ $h2[k])
        puts pentagonal?($h2[k]- $h2[j])
      end
      #puts [j,k].inspect if mandatory_penta(p2,p1) && pentagonal?(p2 - p1) && pentagonal?(p1 + p2) 
    end
  end
end
