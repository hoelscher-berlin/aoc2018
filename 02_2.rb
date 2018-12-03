def lev s, t
  @memo ||= {}
  return t.size if s.empty?
  return s.size if t.empty?
  min = [ (@memo[[s.chop, t]] || (lev s.chop, t)) + 1,
           (@memo[[s, t.chop]] || (lev s, t.chop)) + 1,
           (@memo[[s.chop, t.chop]] || (lev s.chop, t.chop)) + (s[-1] == t[-1] ? 0 : 1)
       ].min
  @memo[[s, t]] = min
end

lines = Array.new

File.open("inputs/02").each do |line|
    lines << line
end

lines.each do |line1|
  lines.each do |line2|
    if lev(line1, line2) == 1
      puts line1 + " " + line2
    end
  end
end