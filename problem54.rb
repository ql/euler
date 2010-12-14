#!/usr/bin/ruby
require 'euler_helper.rb'

#card = 6S
VALUES = %w{2 3 4 5 6 7 8 9 T J Q K A}
NAMES = [:rflush, :sflush, :four, :fhouse, :flush, :straight, :three, :two, :one]

HANDS = {
  :rflush => lambda{|cards| same_suit(cards) && arr_in(%w{T J Q K A}, values(cards)) },#jh: Ten, Jack, Queen, King, Ace, in same suit.
  :sflush => lambda{|cards| arr_in(%w{T J Q K A}, values(cards)) },#Flush: All cards are consecutive values of same suit.
  :four =>   lambda{|cards| max_is(cards, 4) },#   of a Kind: #Four cards of the same value.
  :fhouss=>  lambda{|cards| combinations(cards).values.sort == [2,3] },#lambda {#House: Three of a kind and a pair.
  :flush =>  lambda{|cards| same_suit(cards) },#:# All cards of the same suit.
  :straight=>lambda{|cards| arr_in(VALUES, values(cards))  },# All cards are consecutive values.
  :three=>   lambda{|cards| max_is(cards, 3) }, #of a Kind: Three cards of the same value.
  :two=>     lambda{|cards| max_is(cards, 2) }, #Pairs: Two different pairs.
  :one=>     lambda{|cards| values(cards).first} #Pair: Two cards of the same value.
}

def eq arr1, arr2
  arr1.sort == arr2.sort
end

def arr_in arr1, arr2 #consecutive
  indices = arr2.map {|val| arr1.index(val)}
  return unless indices.grep(nil).empty?
  res = true
  until indices.empty?
    nxt = indices.shift
    res &= (indices.empty? || nxt == (indices.first-1))
  end
  res
end

def max_is cards, n
  m = combinations(cards).max_by{|k,v| v}
  return m.first if m.last == n
end

def same_suit cards
  suites(cards).uniq.size == 1 
end

def suite card
  card[1..1]  
end

def suites cards
  cards.map{|c| suite(c)}
end

def value card
  card[0..0]  
end

def values cards
  cards.map{|c| value(c)}
end

def combinations cards
  values(cards).inject({}){|acc, val| acc[val] = acc[val] ? acc[val]+1 : 1; acc }
end

def hand cards
  raise 'should be 5 cards' unless cards.size == 5
  name = NAMES.detect{|name| HANDS[name].call(cards)}
  [name, HANDS[name].call(cards) ]
end

def parseline cardline
  cs = cardline.split(/\s/)
  [cs[0...5], cs[5...10]]
end

def parse cardline
  cardline.split(/\s/)
end

cards = <<CARD
5H 5C 6S 7S KD 2C 3S 8S 8D TD
5D 8C 9S JS AC 2C 5C 7D 8S QH
2D 9C AS AH AC 3D 6D 7D TD QD
4D 6S 9H QH QC 3D 6D 7H QD QS
2H 2D 4C 4D 4S 3C 3D 3S 9S 9D
CARD

cards.split(/\n/).each do |line|
  puts line
  puts parseline(line).map{|c| hand(c)}.inspect
end
