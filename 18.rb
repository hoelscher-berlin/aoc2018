@field = []
@xsize = 50
@ysize = 50

File.open("inputs/18").each do |line|
  @field << line.delete("\n").split('')
end



def surround(y,x,type)
  sum = 0
  directions = [[1,1],[1,0],[-1,1],[-1,-1],[1,-1],[0,1],[0,-1],[-1,0]]

  directions.each do |dir|
    newy = y+dir[0]
    newx = x+dir[1]

    next if newy<0 or newy > @ysize-1 or newx < 0 or newx > @xsize-1

    if @field[newy][newx] == type
      sum+=1
    end
  end
  sum
end

for i in 1..1000 do
  new_field = []

  for i in 0..@ysize-1 do
    line = []
    for j in 0..@xsize-1 do
      case @field[i][j]
      when "."
        if surround(i,j,"|") >= 3
          #puts "surround of " + i.to_s+","+j.to_s+" sign | is >3 so putting |"
          line << "|"
        else
          line << "."
        end
      when "#"
        if surround(i,j,"#") >= 1 and surround(i,j,"|") >=1
          line << "#"
        else
          line << "."
        end
      when "|"
        if surround(i,j,"#") >= 3
          line << "#"
        else
          line << "|"
        end
      end
    end
    new_field << line
  end

  @field = Marshal.load(Marshal.dump(new_field))

  lumber = 0
  wood = 0
  @field.each do |line|
    line.each do |c|
      if c == "#"
        lumber += 1
      elsif c=="|"
        wood += 1
      end
    end
  end

  puts (lumber*wood).to_s

  #@field.each do |line|
  #  puts line.join('')
  #end

end