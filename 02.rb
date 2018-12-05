### part 1 ###

two = 0
three = 0
pos = 0

File.open("inputs/02").each do |line|
    twohere = 0
    threehere = 0 
    chars = line.split('').uniq
    chars.each do |char|
        charcount = line.count(char)
        if charcount == 2 && twohere == 0
            two += 1
            twohere += 1
        elsif charcount == 3 && threehere == 0
            three += 1
            threehere += 1
        end
    end
end

puts (two*three).to_s

### part 2 ###

def dist s, t
  cnt = 0
  for i in 0..(s.length)
    if s[i]!=t[i]
      cnt += 1
      pos = i
    end
  end
  cnt
end
  
lines = Array.new

File.open("inputs/02").each do |line|
    lines << line
end
  
do_break = false
result = ""

lines.each do |line1|
  lines.each do |line2|
    if dist(line1, line2) == 1
      puts line1 + line2
      do_break = true
      break
    end
  end
  break if do_break
end