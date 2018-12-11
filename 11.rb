grid_snr = 8141

grid = Array.new(301) {Array.new(301)}

for x in 1..300
  for y in 1..300
    # Some calculations...
    rackid = x + 10
    powerlevel = rackid * y
    powerlevel += grid_snr
    powerlevel *= rackid
    digit = powerlevel.digits[2]
    if digit.nil? 
      powerlevel = 0
    else
      powerlevel = digit
    end
    powerlevel -= 5
    grid[x][y] = powerlevel
  end
end

max= {:coords => [0,0], :value => 0, :size => 0}
for size in 1..300
  puts size
  for x in 1..300-size
    for y in 1..300-size
      sum = 0
      for i in 0..size-1
        for j in 0..size-1
          sum += grid[x+i][y+j]
        end
      end
      #puts sum
      if sum > max[:value]
        max[:coords] = [x,y]
        max[:value] = sum
        max[:size] = size
        print max
      end
    end
  end
end

#print grid
print max