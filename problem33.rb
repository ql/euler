#!/usr/bin/ruby
require 'euler_helper.rb'



def cancel num, denom
  if res = strikeout(factorize(num), factorize(denom))
    [mul(res.first), mul(res.last)]
  else
    [num, denom]
  end
end

def strikeout a1,a2
  arr1 = a1.clone
  arr2 = a2.clone
  intersect = arr1 & arr2
  return nil if intersect.empty?
  intersect.each do |val|
    while arr1.index(val) && arr2.index(val)
      arr1.delete_at(arr1.index(val))
      arr2.delete_at(arr2.index(val))
    end
  end
  return [arr1, arr2].map{|a| a.empty? ? [1] : a}
end

def curious? num_arr, denom_arr
  unorto_canceled = strikeout(num_arr, denom_arr)
  #puts '-' +[num_arr, denom_arr].map{|a| a.join.to_i}.inspect
  orto_canceled = cancel(*[num_arr, denom_arr].map{|a| a.join.to_i})
  return false unless unorto_canceled && orto_canceled
  unorto_canceled = cancel(*unorto_canceled.map{|a| a.join.to_i})
  return false unless unorto_canceled && orto_canceled

  if (orto_canceled && orto_canceled == unorto_canceled) 
    orto_canceled
  else
    nil
  end
end

res = []
puts curious?([6,8], [8,9]).inspect
puts curious?([6,5], [2,6]).inspect
(1..99).each do |n|
  (1..99).each do |d|
    next if (n == d) || (n % 10 == 0) || (d % 10 == 0)
    nn, dd = *([n,d].map{|v| v.to_s.split(//).map{|c| c.to_i}})
    r = curious?(nn,dd)
    if r
      res.push(r) 
      puts "#{n}/#{d} -> #{r.first}/#{r.last}"
    end
   end
end

