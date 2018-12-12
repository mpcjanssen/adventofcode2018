TEST_START = "##..##....#.#.####........##.#.#####.##..#.#..#.#...##.#####.###.##...#....##....#..###.#...#.#.#.#"
RULES = <<-END
##.#. => .
##.## => .
#..## => .
#.#.# => .
..#.. => #
#.##. => .
##... => #
.#..# => .
#.### => .
..... => .
...#. => #
#..#. => #
###.. => #
.#... => #
###.# => #
####. => .
.##.# => #
#.#.. => #
.###. => #
.#.## => .
##### => #
....# => .
.#### => .
.##.. => #
##..# => .
#...# => .
..### => #
...## => .
#.... => .
..##. => .
.#.#. => #
..#.# => #
END


class Pots
  @pots = Array(Int32).new
  def initialize(start : String , @rules : Array(Rule))
    start.each_char_with_index do |char,idx|
      @pots << idx if char == '#'
    end
  end

  def filled?(id)
    @pots.includes?(id) 
  end

  def charat(id)
    filled?(id) ? '#' : '.'
  end

  def sum
    @pots.sum
  end

  def minmax
    # p @pots
    @pots.minmax
  end

  ## Return the environments for all the pots to consider
  def env(id)
    env = Array(Char).new
    (-2..2).each do | offset |
      # p offset+id+4
      env << charat(offset+id)
    end
    {id, env.join}
  end
  def envs
    startid,endid = minmax
    startid-=2
    endid+=2
    # p startid
    # p endid
    (startid..endid).map do |id|
      # p id
      env(id)
    end
  end
  def render
    result = Array(Char).new
    x,y = minmax
    # p x,y
    (x..y).each do |id|
      result << charat(id)
    end
    p result.join
  end

  def nextgen()
    # p @pots
    # p envs
    # p @rules
    newpots = Array(Int32).new
    # p envs
    envs.map do |id, e|
      m = @rules.find do |r|
        r.matches(e)
      end
      newpots << id if m && m.result == '#'
    end
    # p newpots
    @pots = newpots
  end
end

class Rule
  getter result
  def initialize(@mask : String, @result : Char)
  end
  def matches(env : String)
    # p @mask
    # p env
    # p @mask == env
    # p "matched" if @mask == env
    @mask == env
  end
end


rules = RULES.each_line.map do |l|
  mask, result = l.split(" => ")
  Rule.new(mask,result[0])
end

pots = Pots.new(TEST_START, rules.to_a)
5000000000.times do | t |
  puts "Day 12-1: #{pots.sum}" if t == 20
pots.nextgen
  pots.render if t % 1000 == 0
end


