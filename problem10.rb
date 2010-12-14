#!/usr/bin/ruby
require 'benchmark'

def primes_under_detect x
  primes = [2]

  i = 3
  while i < x 
    sq = Math.sqrt(i).round
    primes.push(i) unless primes.detect {|divisor| (divisor <= sq) ?  (i % divisor == 0) : break}
    i += 2
  end
  primes
end

def primes_under_while x
  primes = [2]

  i = 3
  j = 0
  r = nil
  while i < x 
    sq = Math.sqrt(i).to_i
    primes.push(i) unless begin
      j = 0
      r = nil
      ps = primes.size
      while j < ps
        break if (primes[j] > sq)
        if (i % primes[j] == 0)
          r = true
          break
        end
        
        j+=1
      end
      r
    end
    i += 2
  end
  primes
end


res = nil 
puts Benchmark.measure { res = primes_under_detect(2000000).inject(0){|acc, i| acc+=i} }
puts res.inspect
puts Benchmark.measure { res = primes_under_while(2000000).inject(0){|acc, i| acc+=i} }
puts res.inspect
