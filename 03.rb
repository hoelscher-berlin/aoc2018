field = Array.new(1000) {Array.new(1000, '.')}
cnt = 0

File.open("inputs/03").each do |line|
  new = line.split(' ')
  number = new[0].delete('#').to_i

  x = new[2].delete(':').split(',')[0].to_i
  y = new[2].delete(':').split(',')[1].to_i
  xend = x + new[3].split('x')[0].to_i - 1
  yend = y + new[3].split('x')[1].to_i - 1

  clean = true

  for i in y..yend
    for j in x..xend
      if field[i][j] == '.'
        field[i][j] = 'o'
      else
        field[i][j] = 'x'
      end
    end
  end
end

field.each do |lines|
  lines.each do |spot|
    if(spot) == 'x'
      cnt +=1
    end
  end
end

dirty = 0
mindirty = 100000
clean = 5000

File.open("inputs/03").each do |line|
  new = line.split(' ')
  number = new[0].delete('#').to_i

  x = new[2].delete(':').split(',')[0].to_i
  y = new[2].delete(':').split(',')[1].to_i
  xend = x + new[3].split('x')[0].to_i - 1
  yend = y + new[3].split('x')[1].to_i - 1

  dirty = 0

  for i in y..yend
    for j in x..xend
      if field[i][j] == 'x'
        dirty += 1
      end
    end
  end

  if dirty < mindirty
    mindirty = dirty
    clean = number
  end
end

puts field.map { |x| x.join(' ') }
puts cnt
puts "number " + clean.to_s + " is clean"