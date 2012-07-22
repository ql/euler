require './euler_helper.rb'

lines = []
i = 0
file = File.open('base_exp.txt')
while l = file.gets
 lines << ([i+=1] + l.split(',').map(&:to_f))
end
puts lines.first.inspect

puts "#{lines.size} lines read"

puts lines.sort_by {|l| l[2] * Math.log(l[1]) }.last.inspect
