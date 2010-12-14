#!/usr/bin/ruby
require 'euler_helper.rb'

def digits n, base
  q = []
  each_digit(n, base) {|d| q.unshift(d) }
  q
end

def palindrome? arr
  if arr.size % 2 == 0
    arr[0...(arr.size / 2)] == arr[(arr.size / 2)..(arr.size - 1)].reverse
  else
    arr[0...(arr.size / 2)] == arr[((arr.size / 2) + 1)..(arr.size - 1)].reverse
  end
end

def palindrome_number? n
  [2, 10].reverse.all? {|base| palindrome?(digits(n, base))}
end

benchmark do
  res = (1..1000000).select {|n| palindrome_number?(n) }
  puts res.inspect
  puts sum(res)

  #(11..1000000).each {|n| puts n if palindrome_number?(n) }
end
