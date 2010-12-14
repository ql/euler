#!/usr/bin/ruby
require 'euler_helper.rb'

def find_longest_prime_sum bound
  primes = primes_under(bound)
  results = {}
  h = primes.inject({}){|acc, i| acc[i]=1;acc}
  
  prsize = primes.size
  primes.enum_with_index.each do |prime, i|
    sum = prime
    counter = 1
    while  i+counter < prsize-1
      sum += primes[i+counter]
      counter += 1
      sum += primes[i+counter]
      counter += 1
      break if sum > bound
      results[counter] = sum if h[sum]
    end
  end
  [results.keys.max, results[results.keys.max]]
end

benchmark do
  puts find_longest_prime_sum(1000000).inspect
end
