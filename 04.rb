require "time"
log = Array.new
guards = Array.new

File.open("inputs/04").each do |line|
    time = Time.parse(line.slice!(0,19).slice(1,16))
    info = line.delete!("\n")
    log << {:timestamp => time, :info => info}
end

# Sort log entries
log.sort_by! {|entry| entry[:timestamp]}

# Set time guards beginning the shift to 00:00
log.find_all {|entry| entry[:timestamp].hour == 23}.each do |entry|
    entry[:timestamp] += (60-entry[:timestamp].min)*60
end

# Group by day (shift)
log_group_by = log.group_by {|entry| entry[:timestamp].strftime("%Y-%m-%d")}

log_group_by.each do |key,shift|
    guard = -1
    shift.each_with_index do |entry, index|
        if index == 0 
            guard = entry[:info].split(' ')[1].slice(1,4).to_i
            guards[guard] ||= Hash.new
            guards[guard][:sleeptime] ||= 0
            guards[guard][:minutes] ||= Array.new(60,0)
        end

        if index % 2 == 0 and index > 0
            finish = entry[:timestamp].min
            start = shift[index-1][:timestamp].min
            guards[guard][:sleeptime] += finish - start     
            for i in start..finish
                guards[guard][:minutes][i] +=1
            end
        end
    end
end

guards.map! {|g| g.nil?? {sleeptime:0, minutes: Array.new(60, 0)} : g} 

max_guard = guards.max_by {|g| g[:sleeptime].to_i}
puts guards.index(max_guard) * max_guard[:minutes].index(max_guard[:minutes].max)

max = {:g => 0, :m => 0, :value => -1}

guards.each_with_index do |g,index| 
    max_this_guard = g[:minutes].max
    minute = g[:minutes].index(max_this_guard)
    if max_this_guard > max[:value]
        max = {:g => index, :m => minute, :value => max_this_guard}
    end 
end

puts max[:g]*max[:m]
