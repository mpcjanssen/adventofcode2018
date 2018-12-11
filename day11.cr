INPUT = 6042

SIZE = 300

def level(serial, x,y)
  rack_id = x + 10
  level = rack_id * y
  level += serial
  level *= rack_id
  hundreds  = level / 100 % 10
  level.sign * hundreds - 5
end

LEVELS = Array.new(SIZE+1) { |x| Array.new(SIZE+1) { |y| level(INPUT,x,y) }}
# 
p level(8,3,5)
p level(57,122,79)
p level(39,217,196)
p level(71,101,153)
 
# p levels


class Block
  getter powers : Array(Int32) = [0] 
  def xy
    "#{@x},#{@y}"
  end

  def max_power
    @powers.max
  end

  def power(size)
    @powers.size < size+1 ? -999999 : @powers[size]
  end

  def initialize(@x : Int32,@y : Int32)
    init_powers
  end
  def init_powers
    max_size = [SIZE-@x, SIZE-@y].min
    # p xy
    # p max_size
    (1..max_size).each do |size|
      total = @powers[size-1]
      (@x...(@x+size)).each { |x| total += LEVELS[x][@y+size-1] }
      (@y...(@y+size)).each { |y| total += LEVELS[@x+size-1][@y] }
      @powers << total
    end

  end
end

blocks = Array(Block).new
(1..SIZE).each do |x|
  (1..SIZE).each do |y|
    blocks << Block.new(x,y)
  end
end

puts "Day11-1: #{(blocks.sort_by &.power(3)).last.xy}"
