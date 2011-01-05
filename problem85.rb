require 'euler_helper.rb'

def p k,l
  r = 0
  for i in 1..k do
    for j in 1..l do
      r += (k-i+1) * (l-j+1)
    end
  end
  r
end


benchmark do
  r = {}
  for x in 1999..2809
    factors = factors_all(x).select {|f| f <= Math.sqrt(x).to_i }
    factors.each do |f|
      r[p(f, x/f)] = [f, x/f]
    end
  end
  
  min = r.keys.map{|k| (2_000_000 - k).abs }.min
  key = r.keys.detect {|k| (2_000_000 - k).abs == min }
  puts key.inspect
  puts r[key].inspect
end
