require './euler_helper.rb'
pars = [
"%f %s %f %s %f %s %f",
"(%f %s %f %s %f) %s %f",
"((%f %s %f) %s %f) %s %f",
"(%f %s (%f %s %f)) %s %f",
"%f %s (%f %s %f %s %f)",
"%f %s ((%f %s %f) %s %f)",
"%f %s (%f %s (%f %s %f))",
"%f %s (%f %s %f) %s %f",
"(%f %s %f) %s (%f %s %f)"]

ars = %w{+ - / *}.repeated_permutation(3)
def a ar
  i = 0
  while ar[i+1] == ar[i]+1
    i +=1
  end
  i + 1
end


benchmark do
vs = {}
for d in 9.downto(4) do
  for c in 8.downto(3) do
    for b in 7.downto(2) do
      for a in 6.downto(1) do
        vs[[a,b,c,d].join] = [a,b,c,d].permutation.map do |nums|
           ars.map do |perm|
            vp = []
            vp << nums[0]
            vp << perm[0]
            vp << nums[1]
            vp << perm[1]
            vp << nums[2]
            vp << perm[2]
            vp << nums[3]
            pars.map do |p|
              begin
                q = eval(p % vp)
                if int?(q)
                  q.to_i 
                else
                  nil
                end
              rescue
                nil
              end
            end
          end
        end.flatten.compact.uniq.select {|v| v > 0 }.sort

      end
    end
  end
end


max = 0
key = nil
vs.each {|k, v| 
  if a(v) > max
    max = a(v)
    key = k
  end
}

puts key


end
