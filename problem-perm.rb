def perm arr
  return arr if arr.size <= 1
  arr.map {|i| perm(arr - [i]).map{|p| ([i] + [p]).flatten }}.inject(:+)
end

puts perm([:a]).size
puts perm([:a, :b]).size
puts perm([:a, :b, :c]).size
puts perm([:a, :b, :c, :d, :e]).size
puts [:a, :b, :c, :d, :e].permutation.to_a.size
