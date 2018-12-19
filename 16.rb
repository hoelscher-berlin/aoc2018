require 'json'

ops = []
sample = [[3,2,1,1], [9,2,1,2], [3,2,2,1]]
@r = [0,0,0,0]
code_to_run = []

empty_ctr = 0

File.open("inputs/16").each_with_index do |line,i|
  if line[0] == "\n"
    # Skip second input part for part 1 of the task
    empty_ctr +=1
  elsif empty_ctr == 3
    code_to_run << JSON.parse("["+line.delete("\n").split(' ').join(',')+"]")
  else
    empty_ctr = 0
    case i%4
    when 0
      ops << [JSON.parse(line.delete("\n").split(': ')[1])]
    when 1 
      ops[i/4] << JSON.parse("["+line.delete("\n").split(' ').join(',')+"]")
    when 2
      ops[i/4] << JSON.parse(line.delete("\n").split(': ')[1])
    end
  end
end

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

methods = [method(:addr),method(:addi),method(:mulr),method(:muli),
           method(:banr),method(:bani),method(:borr),method(:bori),
           method(:setr),method(:seti),method(:gtir),method(:gtri),
           method(:gtrr),method(:eqir),method(:eqri),method(:eqrr)]

#ops = [sample]

ops_greater_three = 0
methods_fitting_opnr = Array.new(16) {[]}

ops.each do |op|
  ctr = 0
  possible_nrs = []
  methods.each_with_index do |m,i|
    @r = Marshal.load(Marshal.dump(op[0]))
    m.call(op[1][1],op[1][2],op[1][3])
    if @r == op[2]
      ctr +=1
      possible_nrs << i
    end
  end
  methods_fitting_opnr[op[1][0]] << possible_nrs
  if ctr >= 3
    ops_greater_three +=1
  end

  possible_nrs
end

puts ops_greater_three

# I used the output of this to manually sort out the opcode - method relationships
for i in 0..15
  #puts "regarding opcode "+i.to_s
  methods_fitting_opnr[i][0].each do |m|
    if methods_fitting_opnr[i].all? {|thing| thing.include?(m)}
      #puts m
    end
  end
end

# Nothing is better than some good old Handarbeit
opc_to_method = [1,5,10,6,15,7,12,8,3,9,4,11,13,14,0,2]

@r = [0,0,0,0]
code_to_run.each do |code|
  methods[opc_to_method[code[0]]].call(code[1],code[2],code[3])
end
print @r[0]
