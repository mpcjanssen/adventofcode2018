class Req
  getter req,step
  def initialize(@req : String, @step : String)
  end
end

def parse_file
  reqs = Array(Req).new
  File.read_lines("input.7.txt").each do |l|
    /Step (.).*step (.)/.match(l).try do |m|
      reqs << Req.new(m[1],m[2])
    end
  end
  reqs
end

reqs = parse_file.sort_by(&.req)
steps = (reqs.map &.req + reqs.map &.step).uniq
wip = Array(String).new
elves_in_progess = Array(Bool).new(5)
order = Array(String).new
while order.size < steps.size
  steps_left = steps-order
  p "l",steps_left
  steps_with_reqs = reqs.map &.step
  available = (steps - order) - steps_with_reqs
  p "a", available
  order << available.first
  reqs = reqs.reject { |r| order.includes? r.req }
  # p reqs
end
p order.join()

class Step
  getter name, :next, prev

  def initialize(@name : Char)
    @next = [] of Step
    @prev = [] of Step
  end

  def time
    61 + (name - 'A')
  end
end

class Worker
  property step : Step?
  property time = 0
end

input = File.read("#{__DIR__}/input.7.txt").chomp

steps = Hash(Char, Step).new { |h, k| h[k] = Step.new(k) }

input.each_line do |line|
  line =~ /Step (\w) must be finished before step (\w) can begin./
  c1, c2 = $1[0], $2[0]
  s1, s2 = steps[c1], steps[c2]
  s1.next << s2
  s2.prev << s1
end

total_time = 0
done = 0
workers = Array.new(5) { Worker.new }
free_steps = steps.values.select { |step| step.prev.empty? }

steps.size.times do
  free_steps.sort_by!(&.name)

  workers.each do |worker|
    break if free_steps.empty?
    next if worker.step

    free_step = free_steps.shift
    worker.step = free_step
    worker.time = free_step.time
  end

  next_worker = workers.select(&.step).min_by(&.time)
  step = next_worker.step.not_nil!
  step_time = next_worker.time

  total_time += step_time

  next_worker.step = nil

  workers.each do |worker|
    next if worker == next_worker
    worker.time -= step_time
  end

  new_free_steps = step.next.select do |next_step|
    next_step.prev.delete(step)
    next_step.prev.empty?
  end

  free_steps.concat(new_free_steps)
end

puts total_time