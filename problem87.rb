require 'euler_helper.rb'

benchmark do
  bound = 50_000_000#
  sq = Math.sqrt(bound)+1
  primes =  primes_under(sq)
  squares = primes.map{|a| a ** 2}
  cubes = primes.map{|a| a ** 3}.select {|a| a < bound }
  fourths = primes.map{|a| a ** 4}.select {|a| a < bound }
  count = {}
  for s in squares do
    for c in cubes do
      for f in fourths do
        sum = s+c+f
         if sum < bound
           count[sum] = 1
         end
      end
    end
  end
  
  puts count.size
end
