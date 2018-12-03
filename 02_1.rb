two = 0
three = 0

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