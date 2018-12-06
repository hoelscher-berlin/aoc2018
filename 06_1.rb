### part 1 ###

def md a,b 
  (a[0]-b[0]).abs + (a[1]-b[1]).abs
end

coords = Array.new

lines = 0

# Read file
File.open("inputs/06").each do |line|
  coords << [line.split(', ')[0].to_i,line.split(', ')[1].strip.to_i]
  lines+=1
end

xsize = coords.map{|c| c[0]}.max + 1
ysize = coords.map{|c| c[1]}.max + 1

field = Array.new(ysize) {Array.new(xsize, '.')}

# For the whole field... 
for i in 0..ysize-1
  for j in 0..xsize-1
    dists = Array.new
    # ... calculate distance to each coordinate
    for k in 0..lines-1
      dists[k] = md([j,i], coords[k])
    end
    # Contested minimum distances don't count
    if dists.count(dists.min) > 1
      field[i][j] = '.'
    else
      field[i][j] = dists.index(dists.min)+1
    end
  end
end

# Find largest non-infinite field

legit_fields = (1..50).to_a

# Check left and right border

for i in 0..ysize-1
  for k in 0..lines-1
    if field[i][0] == k
      legit_fields.delete(k)
    end
  end
  for k in 0..lines-1
    if field[i][xsize-1] == k
      legit_fields.delete(k)
    end
  end
end

# Check top and bottom border

for i in 0..xsize-1
  for k in 0..lines-1
    if field[0][i] == k
      legit_fields.delete(k)
    end
  end
  for k in 0..lines-1
    if field[ysize-1][i] == k
      legit_fields.delete(k)
    end
  end
end

# "Flatten" the two dimensional field 
wholefield = Array.new
field.each do |y|
  wholefield += y
end

# Only take the non-infinite fields and count the occurrences
count = Hash.new 0
wholefield.select { |num| legit_fields.include?(num) }.each do |coord|
  count[coord]+=1
end

# Find maximum

puts count.max_by {|key,value| value}