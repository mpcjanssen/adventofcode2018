

def letters_freq(word) 
    word.split("").reduce({} of String => Int32) do | h, c |
    current = h.fetch(c,0)
    h[c] = current + 1
    h
    end
end

def freq_has(freq, n)
    return freq.values.includes?(n)
end

def day2_1(ids)
    tally = {} of Int32 => Int32
    ids.reduce(tally) do |t, w| 
        freq = letters_freq(w)
        # puts freq
        if (freq_has(freq,2))
            t[2] = t.fetch(2,0)+1
        end
        if (freq_has(freq,3))
            t[3] = t.fetch(3,0)+1
        end
        t
    end
    tally[2] * tally[3]
end

def distance(chars1,chars2)
    distance = 0
    chars1.zip(chars2) do | a , b |
        distance = distance + 1 if a != b 
    end
    distance
end

def common_letters(a,b) 
    a.zip(b).select { | x,y | x == y }.map { | x | x[0]}
end

def day2_2(ids)
    split_ids = ids.map { |x | x.split("") }
    while split_ids.size != 0
      x = split_ids.pop
      distances = split_ids.map {|id| {id, distance(id,x)}}
      match = distances.select { |x | x[1] == 1}
      return common_letters(x,  match[0][0]).join("") if match.size > 0
    end
end

# puts letters_freq("saaas")

ids =   File.read_lines("input.2.txt")
puts "Day2-2: #{day2_1(ids)}"
puts "Day2-2: #{day2_2(ids)}"


