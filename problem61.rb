#!/usr/bin/ruby
require 'euler_helper.rb'
functions = [:triangle, :square, :penta, :hexa, :hepta,:octa]
def hsel h, key
  r = h.clone
  r.delete key
  r
end

def triangle n
  n*(n+1)/2
end

def square n
  n ** 2
end

def penta n
  n*(3*n-1)/2
end

def hexa n
  n*(2*n-1)
end

def hepta n
  n*(5*n-3)/2
end

def octa n
  n*(3*n-2)
end

def filt arr, target
  upper_bound = (target.digits[2...4].join.to_i + 1) * 100
  lower_bound = (target.digits[2...4].join.to_i) * 100
  arr.select {|n| (n > lower_bound) && (n < upper_bound)}
end


def solve numbers, functions, results, init
  ret = nil
  results = results.clone
  fun = functions.shift
  return nil unless fun
  if init
    to_iter = filt(numbers[fun], init)
  else
    to_iter = numbers[fun]
  end
  
  raise 'Error!' if functions.empty? && results.size < 2
  if functions.empty?
    numlast = to_iter.detect {|n| n.digits[2...4] == results.first.digits[0...2] }
    return (results + [numlast]) if numlast
    return nil
  else
    to_iter.each do |num|
      functions.each do |f|
        r = solve(hsel(numbers, fun), ([f] + (functions-[f])), results + [num], num)
        ret = r unless r.nil?
      end
    end
  end
  ret
end
values = functions.inject({}) {|acc, fun| acc[fun] = (1..150).map{|n| send(fun, n)}.select {|n| n >= 1000 && n <= 9999 };acc }
puts values.values.map(&:size).inspect
values.each {|k,v|
}

functions.each do |f|
  (functions-[f]).each { |f2| values[f] -= values[f2] }
end

benchmark do
  puts sum(solve(values, functions, [], nil))
end
