#!/bin/env ruby
require 'euler_helper.rb'

def range
  range = 1..10
end

def find used = []
  range.to_a.except(used).inject([]) do |acc1, p1|
    acc1 += range.to_a.except(used, p1).inject([]) do |acc2, p2|
      acc2 += range.to_a.except(used, p1, p2).map{|x| [p2]+[x]}
    end.map {|x| [p1]+x.to_a}
  end
end

def nxt triple, used = []
#  puts triple.inspect
#  puts used.inspect
#  puts used.except(triple.last)
  find(used.except(triple.last)).select {|triple2| triple.last == triple2[1]}
end

def nxt_try triple, n, used = []
  variants = nxt(triple, used).select {|arr| arr.sum == triple.sum}
  if n == 0
    variants 
  else
    variants.inject([]) do |acc, triple1|
      acc += nxt_try(triple1, n-1,used+triple1).inject([]) do |acc2, triple2|
        unless tripl2.empty?
          acc2 += triple2
        else
          acc2 
        end
      end.map {|s| [triple1] + s}
      acc
    end
  end
end

def solve2
 triples = range.inject([]) do |acc, center| 
   inits = find.select {|arr| arr[1] == center }
   unless inits.empty?
     acc += inits.inject([]) do |acc1, init|
       r= recur(init, 3, [],[],center).inject(:+).inject(:+).inject(:+).select{|a| a.size == 5}.select{|a| a.last.last==a.first[1]} rescue []
       #puts r.inspect
       unless r.empty?
        acc1 += r
       else
        acc1
       end
     end
   else
    acc
   end
 end
end

# nxt_try([4,2,3], 2).each {|a| puts a.inspect }
#solve2.each{|k,v| puts "k: #{k} #{v.inspect}" }

def recur triple, n, used = [], stack = [], enddig = nil
  #puts 'st'+stack.inspect
  #puts 'u'+used.inspect
  stack.push triple
  used += triple
  if n == 0
    variants = nxt(triple, used.except(enddig)).select {|arr| arr.sum == triple.sum}
    if variants.empty?
      return []
    else 
      return variants.map{|v| stack +[v] }
    end
  else
    variants = nxt(triple, used).select {|arr| arr.sum == triple.sum}
    variants.map {|v| recur(v, n-1, used+v, stack.clone, enddig) }
  end
end

puts solve2.inspect
rr = solve2.map{|a| a.map{|x| x.join.to_i}}
rr.delete_if{|arr| rr.detect {|arr2| (arr & arr2).size==arr.size && arr.first != arr.min} }.inspect
#
puts rr.select{|arr| arr.join.size == 16}.map {|arr| arr.join.to_i}.max
