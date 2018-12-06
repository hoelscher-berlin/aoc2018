### part 2 ###

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
    dist = 0
    # ... calculate sum of distances to each coordinate
    for k in 0..lines-1
      #puts "adding " + md([j,i], coords[k]).to_s
      dist += md([j,i], coords[k])
    end
    # Contested minimum distances don't count
    if dist < 10000
      field[i][j] = '#'
    else
      field[i][j] = '.'
    end
  end
end

# "Flatten" the two dimensional field 
wholefield = Array.new
field.each do |y|
  wholefield += y
end

puts wholefield.count("#")