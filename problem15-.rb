#!/usr/bin/ruby

results = {}
def variants m, results
  return results[m] if results[m]
  return 1 if m.last == 0
  return 1 if m.first == 0
  results[m] = variants([m[0]-1, m[1]], results)+variants([m[0], m[1]-1], results)
  results[m]
end

puts variants([20,20],results)
puts results.size
