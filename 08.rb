@nodes = []
@ctr = 0

def parse_node(nr)
  children = @input.shift.to_i
  meta_ctr =  @input.shift.to_i
  
  @nodes << {children: children, meta_ctr: meta_ctr, child_nodes: [], meta: []}
  @ctr += 1

  # Add child nodes recursively
  for i in 1..children
    @nodes[nr][:child_nodes] << @ctr
    parse_node(@ctr)
  end

  # Add metadata
  for i in 1..meta_ctr
    @nodes[nr][:meta] << @input.shift.to_i
  end
end

def value(node_nr)
  node = @nodes[node_nr]
  sum = 0
  if node[:children] == 0
    sum = node[:meta].sum
  else
    node[:meta].each do |m|
      if m <= node[:child_nodes].length
        sum += value(node[:child_nodes][m-1])
      end
    end
  end
  sum
end

File.open("inputs/08").each do |line|
  @input = line.strip.split(' ')
  parse_node(0)
  puts @nodes.sum {|n| n[:meta].sum}
  puts value(0)
end
