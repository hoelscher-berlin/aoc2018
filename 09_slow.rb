players = 0
last_marble = 0

File.open('inputs/09').each do |line|
  players = line.split(' ')[0].to_i
  last_marble = line.split(' ')[6].to_i
end

circle = [0]
current_marble = 0
round = 1
current_player = 1
score = 0
scoreboard = [0] * players

while round <= last_marble do
  # positioning first marble
  if circle.length == 1
    current_marble = 1
    circle << round
  elsif round % 23 == 0
    #puts "SPECIAL"
    scoreboard[current_player] ||= 0
    score = round + circle.delete_at(current_marble - 7)
    scoreboard[current_player] += score

    new_marble_position = current_marble - 7
    if new_marble_position < 0
      #puts "SUPERSPECIAL"
      current_marble = circle.length + new_marble_position + 1
    else
      current_marble = new_marble_position
    end
  else
    current_marble = (current_marble + 2) % circle.length

    if current_marble == 0
      current_marble = circle.length
    end
    
    circle.insert(current_marble, round)
  end

  #str = ""
  #str += "["+current_player.to_s+"]  "
  #circle.each_with_index do |c,i|
  #  if i==current_marble
  #    str += "("+c.to_s+") "
  #  else
  #    str += c.to_s+ " "
  #  end
  #end

  #puts str

  round += 1
  current_player += 1
  if current_player == players + 1
    current_player = 1
  end
end

puts scoreboard.max
