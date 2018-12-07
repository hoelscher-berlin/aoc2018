predecessors = Hash.new
order = Array.new

('A'..'Z').each do |c|
  predecessors[c] = Array.new
end

File.open("inputs/07").each do |line|
  predecessors[line.split('')[36]] << line.split('')[5]
end

print predecessors

while predecessors.count > 0 do
  # Remove immediately doable tasks
  predecessors.each do |c,preds|
    stop = false
    if preds.count == 0
      order << c
      predecessors.delete(c)
      predecessors.each do |d,preds|
        predecessors[d] -= [c]
      end
      stop = true
    end
    break if stop==true
  end  
end

puts order.join ''