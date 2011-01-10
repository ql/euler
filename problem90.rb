require 'euler_helper.rb'
require 'set'

def arr_subs arr1, arr2
  arr1, arr2 = arr1.clone, arr2.clone
  while arr2.size > 0
    arr1.delete_at(arr1.index(arr2.shift))
  end
  arr1
end

def cubinc c1, c2, v1, v2
  (c1.include?(v1) && c2.include?(v2)) || (c1.include?(v2) && c2.include?(v1)) 
end

def rules c1, c2
  return false unless c1.size == c1.uniq.size && c2.size == c2.uniq.size
  return false unless cubinc(c1, c2, 0,1)
  return false unless cubinc(c1, c2, 0,4)
  return false unless cubinc(c1, c2, 0,9) || cubinc(c1, c2, 0, 6)
  return false unless cubinc(c1, c2, 1,6) || cubinc(c1, c2, 1, 9)
  return false unless cubinc(c1, c2, 2,5)
  return false unless cubinc(c1, c2, 3,6) || cubinc(c1, c2, 3, 9)
  return false unless cubinc(c1, c2, 4,9) || cubinc(c1, c2, 4, 6)
  #return false unless cubinc(c1, c2, 6,4) || cubinc(c1, c2, 9, 4) #SAME ^
  return false unless cubinc(c1, c2, 8,1)
  return true
end

def filter_base numbers, n
  numbers.combination(n).to_a.select do |b|
    rules(b, arr_subs(numbers, b))
  end.uniq.inject([]) do |memo, arr|
    memo += [[arr, arr_subs(numbers, arr)]]
  end
end

def repeated_combination k, n
  f(n+k-1)/(f(k)*f(n-1))
end

benchmark do

  variants  = (0..9).to_a.map {|a| [a] * 4 }.flatten.combination(4).map {|c| [0,1,2,3,4,5,8, 6] + c }.uniq
  variants += (0..9).to_a.map {|a| [a] * 4 }.flatten.combination(4).map {|c| [0,1,2,3,4,5,8, 9] + c }.uniq
  variants.map!(&:sort)
  variants.uniq!
  set = variants.inject([]) {|memo, v| overput(v.inspect); memo += filter_base(v, 6) }
  puts
  puts

  set.map!{|pair| Set.new(pair)}
  set.uniq!
  puts set.size
end
