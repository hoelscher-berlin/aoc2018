grid_snr = 8141

grid = Array.new(301) {Array.new(301)}
lastpower = Array.new(301) {Array.new(301)}

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
    lastpower[x][y] = 0
  end
end

max= {:coords => [0,0], :value => 0, :size => 0}
for size in 1..300
  for x in 1..300-size+1
    for y in 1..300-size+1
      sum = lastpower[x][y]
      for i in x..x+size-1
        sum += grid[i][y+size-1]
      end
      for i in y..y+size-1
        sum += grid[x+size-1][i]
      end
      lastpower[x][y] = sum 
      if sum > max[:value]
        max[:coords] = [x,y]
        max[:value] = sum
        max[:size] = size
      end
    end
  end
end

print max