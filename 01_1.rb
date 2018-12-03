sum = 0

File.open("inputs/01").each do |line|
    sum += line.to_i
end

puts sum.to_s