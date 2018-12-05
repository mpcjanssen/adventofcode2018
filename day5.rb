polymer = File.read("input.5.txt").chomp
def anti (x,y)
  !x.nil? && x != y && x.casecmp(y).zero?
end

def poly_reduce(p, ignore = "")
    p = p.tr(ignore, "")
    res = [] 
    p.split('').each do |c|
      if !res.empty? && anti(res[-1] , c )
        res.pop
      else
        res << c
      end
    end
    res

  return res
end
puts "5-1: #{poly_reduce(polymer).size}"

experiments = ('a'..'z').map do |x|
  [ poly_reduce(polymer, x + x.upcase).size , x ]
end
puts "5-2: #{experiments.sort.first[0]}"
