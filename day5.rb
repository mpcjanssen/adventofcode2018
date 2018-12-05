polymer = File.read("input.5.txt").chomp
def anti (x,y)
  x != nil && x != y && x.upcase == y.upcase
end

def poly_reduce(p, ignore = "")
  loop do
    work_done = false
    p = p.tr(ignore, "")
    p = p.split('').reduce("") do |acc, c|
      if anti(acc[-1],c) 
        work_done = true
        acc = acc[0...-1] || ""
      else
        acc += c
      end
      acc
    end
    break unless work_done 
  end
  return p
end
puts "5-1: #{poly_reduce(polymer).size}"

experiments = ('a'..'z').map do |x|
  [ poly_reduce(polymer, x + x.upcase).size , x ]
end
puts "5-2: #{experiments.sort.first[0]}"
