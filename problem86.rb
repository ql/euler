require 'euler_helper.rb'
require 'mathn'

def variants(x, y, bound) #for each pyphagorean triplet there are some cuboids with 1) integer shortest path 2) a,b,c < M
  x, y = [x,y].sort
  count = 0
  c = x # a+b > c
  for a in y-c..y/2
    count +=1 if a <= bound && y-a <= bound && c <= bound
  end
  c = y # a+b < c
  for a in 1..x/2
    count +=1 if a <= bound && x-a <= bound && c <= bound
  end
  count
end

def pyth_triplet m,n
  [m**2 - n**2, 2*m*n, m**2 + n**2]
end

def pyphagorean_triplets bound
  result = []
  b = bound / 4
  (2..b).each do |m|
    (1...m).each do |n|
      next unless m.gcd(n) == 1
      result.push pyth_triplet(m, n).sort
    end
  end
  result.select {|triplet| triplet[0] <= bound && triplet[1] <= (bound * 2)}
end

def derivative_triplets base_triplets, bound
  condition = lambda {|triplet| triplet[0] <= bound && triplet[1] <= bound * 2}
  result = []
  base_triplets.each do |triplet|
    i = 2
    tr = triplet.map {|a| a*i}
    while condition.call(tr)
      result.push tr
      i += 1
      tr = triplet.map {|a| a*i}
    end
  end
  result + base_triplets 
end

def count_cuboids m
  triplets = derivative_triplets(pyphagorean_triplets(m), m).uniq
  variants = triplets.inject(0) {|memo, triplet| memo += variants(triplet[0], triplet[1], m)}
  variants
end

def bisect fun, target, start, eend
  while eend - start > 1
    puts "step "+[start,eend].inspect
    testpoint = ((start+eend) / 2).to_i
    res = send(fun,testpoint)
    if res < target
      start = testpoint
    elsif res > target
      eend = testpoint
    else
      return testpoint
    end
  end
  return start
end

benchmark do
  puts bisect(:count_cuboids, 1000000, 1, 2500).inspect
end
