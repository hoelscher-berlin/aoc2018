require "matrix"

def md a,b 
  (a[0]-b[0]).abs + (a[1]-b[1]).abs
end

def show_stars(m, xsize, ysize)
  grid = Array.new(ysize+1) {Array.new(xsize+1, '.')}
  m.to_a.each do |star|
    grid[star[1]][star[0]] = "#"
  end

  puts grid.map { |line| line.join(' ') }
end

stars = []
vs = []

File.open("inputs/10").each do |line|
  l = line.split('velocity')
  p0 = l[0].split('<')[1].split(',')[0].to_i
  p1 = l[0].split('<')[1].split(',')[1].delete('>').to_i
  v0 = l[1].split('<')[1].split(',')[0].to_i
  v1 = l[1].split('<')[1].split(',')[1].delete('>').to_i

  stars << Vector[p0,p1]
  vs << Vector[v0,v1]
end

m = Matrix.rows(stars)
v = Matrix.rows(vs)

step = 1
while true do
  # Move!
  m += v

  # Calculate window size
  max_x = 0
  max_y = 0
  min_x = 100000
  min_y = 100000
  m.to_a.each do |star|
    if star[0] > max_x
      max_x = star[0]
    end
    if star[0] < min_x
      min_x = star[0]
    end
    if star[1] > max_y
      max_y = star[1]
    end
    if star[1] < min_y
      min_y = star[1]
    end
  end

  # Manually chosen: window with the letters shouldn't be bigger than 100x100
  if max_x - min_x < 100 and max_y-min_y < 100
    puts "aw yeah!"
    puts step
    show_stars(m, max_x, max_y)
  end

  step += 1
end