DIM = 1000 
fabric = Array.new(DIM) { |i| Array.new(DIM) { |j| 0 } }

claims = File.read_lines("input.3.txt")
claims.each do | claim | 
  orig, size =  claim.split("@")[1].split(":")
  p orig.strip,size.strip
  tx,ty = orig.strip.split(",")
  tdx,tdy = size.strip.split("x")
  x,y  = tx.to_i, ty.to_i
  dx,dy  = tdx.to_i, tdy.to_i
  (x...(x+dx)).each do | x |
    (y...(y+dy)).each do | y |
      fabric[x][y] += 1
    end
  end
end
p fabric
p (fabric.map &.select { | x  | x > 1}.size).sum
