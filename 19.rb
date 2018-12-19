# reused from day 16

def addr(a,b,c)
  @r[c] = @r[a] + @r[b]
end

def addi(a,b,c)
  @r[c] = @r[a] + b
end

def mulr(a,b,c)
  @r[c] = @r[a] * @r[b]
end

def muli(a,b,c)
  @r[c] = @r[a] * b
end

def banr(a,b,c)
  @r[c] = @r[a] & @r[b]
end

def bani(a,b,c)
  @r[c] = @r[a] & b
end

def borr(a,b,c)
  @r[c] = @r[a] | @r[b]
end

def bori(a,b,c)
  @r[c] = @r[a] | b
end

def setr(a,b,c)
  @r[c] = @r[a]
end

def seti(a,b,c)
  @r[c] = a
end

def gtir(a,b,c)
  if a > @r[b]
    @r[c] = 1
  else
    @r[c] = 0
  end
end

def gtri(a,b,c)
  if @r[a] > b
    @r[c] = 1
  else
    @r[c] = 0
  end
end

def gtrr(a,b,c)
  if @r[a] > @r[b]
    @r[c] = 1
  else
    @r[c] = 0
  end
end

def eqir(a,b,c)
  if a == @r[b]
    @r[c] = 1
  else
    @r[c] = 0
  end
end

def eqri(a,b,c)
  if @r[a] == b
    @r[c] = 1
  else
    @r[c] = 0
  end
end

def eqrr(a,b,c)
  if @r[a] == @r[b]
    @r[c] = 1
  else
    @r[c] = 0
  end
end

ip_reg = 0
ip = 0
instructions = []

File.open("inputs/19").each do |line|
  if line[0] == "#"
    ip_reg = line[4].to_i
    next
  end

  line = line.split(' ')
  instructions << {meth: line[0], params: line[1,3].map{|x| x.to_i }}
end

# change here for part 1
@r = [1,0,0,0,0,0]

while @r[ip_reg] < instructions.length
  next_instr = @r[ip_reg]
  meth = instructions[next_instr][:meth]
  params = instructions[next_instr][:params]
  
  # code optimization!
  if next_instr == 3
    if @r[5] % @r[2] == 0
      # counting variable reached maximum
      @r[3] = @r[5]
      # the comparison register is 1 
      @r[4] = 1
      # we jump to ip #7
      @r[ip_reg] = 7
    else
      # the counting variable is 1 too high
      @r[3] = @r[5] + 1
      # the comparison register is 1
      @r[4] = 1
      # we jump to ip #12
      @r[ip_reg] = 12
    end
  else
    send(meth.to_sym, params[0], params[1], params[2])
    @r[ip_reg] += 1
  end
  #puts 
  
end

puts @r[0]