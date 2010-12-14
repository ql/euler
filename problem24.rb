#!/usr/bin/ruby
<<COMMENT
A permutation is an ordered arrangement of objects. For example, 3124 is one possible permutation of the digits 1, 2, 3 and 4. If all of the permutations are listed numerically or alphabetically, we call it lexicographic order. The lexicographic permutations of 0, 1 and 2 are:

012   021   102   120   201   210

What is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?
COMMENT

def f n
  r = 1
  i = n
  while i > 1
    r *= i
    i -= 1
  end
  r
end

def countable_permutation elements, number
  return [] if elements.empty?
  elements.sort!
  new_number = number % f(elements.size - 1)
  nth_elem = elements.delete_at(number / f(elements.size - 1))
  return [nth_elem] + countable_permutation(elements, new_number)
end

puts countable_permutation((0..9).to_a, 1000000-1).join
