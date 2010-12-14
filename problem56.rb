#!/usr/bin/ruby
require 'euler_helper.rb'

puts (1..100).detect {|b| sum((99 ** b).digits) == 972 }
