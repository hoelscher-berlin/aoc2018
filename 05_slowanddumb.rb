input_string = ""
input = Array.new

class String
  def is_up?
    self == self.upcase
  end
  def is_low?
    self == self.downcase
  end
end

File.open("inputs/05").each do |line|
  input_string = line.delete("\n")
  input = input_string.split('')
end

def react(inp)
  reaction = true
  while reaction do
    reaction = false
    len = inp.length
    for i in 1..inp.length-1 do
      break if i >= inp.length

      if inp[i-1]!=inp[i] and inp[i-1].downcase == inp[i].downcase
        reaction = true
        inp.delete_at(i)
        inp.delete_at(i-1)
      end
    end
  end
  inp.length
end

puts react(input)

results = Array.new

("a".."z").each { |char|
  inp = input_string.delete(char).delete(char.upcase).split('')
  puts results << react(inp)
}

puts results.min