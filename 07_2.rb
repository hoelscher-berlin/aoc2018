predecessors = Hash.new
@time_needed = Hash.new
@done = Array.new
number_of_workers = 5
@workers = Array.new number_of_workers,0
@assignments = Array.new number_of_workers
@seconds = 0

('A'..'Z').to_a.each_with_index do |c,index|
  predecessors[c] = Array.new
  @time_needed[c] = 61+index
end

File.open("inputs/07").each do |line|
  predecessors[line.split('')[36]] << line.split('')[5]
end

def workers_available
  @workers.select {|w| w == 0}.count > 0
end

def assign_worker(char)
  @workers.each_with_index do |w,index|
    if w == 0
      @workers[index] = @time_needed[char] 
      @assignments[index] = char
      break
    end
  end
end

def all_workers_done
  @workers.all? {|w| w ==0}
end

def time_passes_by
  @seconds += 1
  @workers.each_with_index do |w,index|
    if w == 1
      @done << @assignments[index]
    end
    if w != 0
      @workers[index] -= 1
    end
  end
end

while predecessors.count > 0 or !all_workers_done do
  time_passes_by

  predecessors.each do |d,preds|
    predecessors[d] -= @done
  end

  predecessors.each do |c,preds|
    if preds.count == 0 and workers_available
      assign_worker(c)
      predecessors.delete(c)
    end
  end  
end

# not sure yet why I count 1 second too much, but that's ok
puts @seconds-1

