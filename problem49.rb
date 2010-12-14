#!/usr/bin/ruby
require 'euler_helper.rb'

def permutations? numbers
  numbers.map(&:digits).map(&:sort).inject{|acc, i| (acc == i) ? acc : nil }
end
def test p, h
  r = h.keys.map do |a|
    [a,p, p+p-a] if a < p && h[(p + (p - a))] && permutations?([a,p, p+p-a])
  end.compact
  r unless r.empty?
end

benchmark do
  primes = primes_under(10000).select {|p| p>1000}
  h = primes.inject({}) {|acc,i| acc[i]=1; acc}

  puts primes.map {|pp| test(pp, h) }.compact.map(&:join).inspect
end
