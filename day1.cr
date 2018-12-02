lines = File.read_lines("input.1.txt").map { |x| x.to_i }

total = lines.reduce(0) do | x, y | 
    x + y
end
puts "Day1-1: #{total}"


def firstDouble(lines)
    seen = Set{0}
    freq = 0
    lines.cycle.each do | x |
        freq = freq + x
        if seen.includes? freq
            return freq
        end
        seen.add(freq) 
    end
end

puts "Day1-2: #{firstDouble(lines)}"