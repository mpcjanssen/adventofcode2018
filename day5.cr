polymer = File.read("input.5.txt").chomp
def anti (x,y)
  x != nil && x != y && x.upcase == y.upcase
end

def poly_reduce(p, ignore = "")
  loop do
    work_done = false
    p = p.tr(ignore, "")
    p = p.each_char.reduce("") do |acc, c|
      prev = acc.empty? ? "" : acc[acc.size-1]
      if anti(prev,c) 
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
  { poly_reduce(polymer, x.to_s + x.to_s.upcase).size , x.to_s }
end
puts "5-2: #{experiments.sort.first[0]}"
