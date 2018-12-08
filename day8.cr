def parse_file
  File.read("input.8.txt").split.map &.to_i
end

nums =  parse_file

def parse_node(nums)
  metadata = Array(Int32).new
    # p nums
    children = nums.shift
    metadata_size = nums.shift
    # p children, metadata_size
    children.times do
      # p "--" 
      nums, md = parse_node(nums)
      metadata = metadata + md
    end
    metadata_size.times do
      metadata << nums.shift
    end 
  # p "==="
  # p metadata,nums
  {nums, metadata}
end

p parse_node(nums)[1].sum