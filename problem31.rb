#!/usr/bin/ruby
#
require 'euler_helper.rb'

res = {}
def countcoins coins, s, res
  return res["#{sum(coins)}#{s}"] if res["#{sum(coins)}#{s}"]
  r =  0 if coins.empty?
  r =  1 if s == 0
  r =  0 if s < 0
  if r
    res["#{sum(coins)}#{s}"] = r
    return r
  end
  return countcoins(coins.slice(1,100), s, res) +
         countcoins(coins, s-coins.first, res)
end

uk_coins = [1, 2, 5, 10, 20, 50, 100, 200]
benchmark do
  puts countcoins uk_coins.reverse, 200, res
end
