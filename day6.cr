class Point
   def initialize(@id : String, line : String)
      
   end
end

def parse_file
  points = [] of Point
  File.read_lines("input.6.txt").each_with_index do |l, idx|
    p Point.new("pt#{idx}", l)
  end
end

parse_file