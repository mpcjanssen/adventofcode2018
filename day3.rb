require 'set'

DIM = 1000


def build_claims
  ids = Set.new
  fabric = Array.new(DIM) { Array.new(DIM) { [] } }
  claims = File.readlines('input.3.txt')
  claims.each do |claim|
    cid, coords = claim.split('@')
    orig, size =  coords.split(':')
    tx, ty = orig.strip.split(',')
    tdx, tdy = size.strip.split('x')
    x = tx.to_i
    y = ty.to_i
    dx = tdx.to_i
    dy = tdy.to_i
    (x...(x + dx)).each do |cx|
      (y...(y + dy)).each do |cy|
        fabric[cx][cy] << cid.strip
        ids << cid.strip
      end
    end
  end
  fabric
end
fabric, ids = build_claims
puts 'Day3-1:', (fabric.map { |y| y.select { |x| x.size > 1 }.size }).reduce(:+)

fabric.each do |r|
  r.each do |cell|
    if cell.size > 1

      # if cell is claimed more than once all claimants should be excluded
      cell.each { |id| ids.delete id }
    end
    if ids.size == 1
      puts 'Day3-2:', ids.first
      exit
    end
  end
end
