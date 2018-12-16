# Output
def show(field, carts)
  field_with_carts = Marshal.load(Marshal.dump(field))
  carts.each do |cart|
    next unless cart[:alive]
    field_with_carts[cart[:y]][cart[:x]] = cart[:direction]
  end

  field_with_carts.each do |line|
    puts line.join('')
  end
end

def next_turn(cart)
  case cart[:turn]
  when "l" 
    "s"
  when "s"
    "r"
  else  
    "l"
  end
end

def direction_after_turn(dir, turn)
  answers = {"<l"=> "v", 
             "<s"=>"<",
             "<r"=>"^",
             ">l"=>"^",
             ">s"=>">",
             ">r"=>"v",
             "vl"=>">",
             "vs"=>"v",
             "vr"=>"<",
             "^l"=>"<",
             "^s"=>"^",
             "^r"=>">"}
  answers[dir+turn]
end

# determine field size

l = []
height = 0
@nr_of_crashes = 0

File.open("inputs/13").each do |line|
  l << line.delete("\n").length
  height += 1
end
length = l.max

field = Array.new(height) {Array.new(length)}
carts = []
cart_shapes = ["<",">","v","^"]

File.open("inputs/13").each_with_index do |line,i|
  line.delete("\n").split('').each_with_index do |c,j|
    field[i][j] = c
    if cart_shapes.include?(c)
      carts << {x: j, y: i, direction: c, turn: "l", alive: true}
      if ["v","^"].include?(c)
        field[i][j] = "|"
      else
        field[i][j] = "-"
      end
    end
  end
end

no_crash = true
ticks = 0
while carts.length > 1 do
  ticks +=1  
  carts.sort_by! { |c| [c[:y],c[:x]] }
  carts.each do |cart|
    case cart[:direction]
    when "<"
      case field[cart[:y]][cart[:x]-1]
      when "/"
        cart[:direction] = "v"
      when "\\"
        cart[:direction] = "^"
      when "+"
        cart[:direction] = direction_after_turn("<",cart[:turn])
        cart[:turn]= next_turn(cart)
      end
      cart[:x] -= 1
    when ">"
      case field[cart[:y]][cart[:x]+1]
      when "/"
        cart[:direction] = "^"
      when "\\"
        cart[:direction] = "v"
      when "+"
        cart[:direction] = direction_after_turn(">",cart[:turn])
        cart[:turn]= next_turn(cart)
      end
      cart[:x] += 1
    when "v"
      case field[cart[:y]+1][cart[:x]]
      when "/"
        cart[:direction] = "<"
      when "\\"
        cart[:direction] = ">"
      when "+"
        cart[:direction] = direction_after_turn("v",cart[:turn])
        cart[:turn]= next_turn(cart)
      end
      cart[:y] += 1
    when "^"
      case field[cart[:y]-1][cart[:x]]
      when "/"
        cart[:direction] = ">"
      when "\\"
        cart[:direction] = "<"
      when "+"
        cart[:direction] = direction_after_turn("^",cart[:turn])
        cart[:turn]= next_turn(cart)
      end
      cart[:y] -= 1
    end

    # Check for crash
    carts.each do |c2|
      if c2[:x] == cart[:x] and c2[:y] == cart[:y] and c2[:alive] and c2 != cart and cart[:alive]
        @nr_of_crashes +=1
        if @nr_of_crashes == 1
          puts c2[:x].to_s + "," + c2[:y].to_s
        end
        c2[:alive] = false
        cart[:alive] = false
      end
    
    
    end
  end
  living_carts = carts.select{|c| c[:alive]}
  if living_carts.size == 1
    puts living_carts[0][:x].to_s+","+living_carts[0][:y].to_s
    break
  end
end

 

