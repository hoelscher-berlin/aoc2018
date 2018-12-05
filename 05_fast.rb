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
  stack = ['']
  for c in inp
    v = stack[-1]
    if v!=c and v.upcase == c.upcase
      stack.pop
    else
      stack.append(c)
    end
  end
  stack.length - 1
end

puts react(input)

results = Array.new

("a".."z").each { |char|
  inp = input_string.delete(char).delete(char.upcase).split('')
  results << react(inp)
}

puts results.min