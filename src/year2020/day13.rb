require 'io/console'

module Year2020
  class Day13
    def part1(input)
      timestamp, bus_lines = input.split("\n")
      timestamp = timestamp.to_i
      bus_numbers = bus_lines.split(",").reject {|line| line == "x"}.map(&:to_i)

      next_bus = bus_numbers.min_by { |bus| ((timestamp / bus) + 1) * bus }
      wait_time = ((timestamp / next_bus) + 1) * next_bus - timestamp
      next_bus * wait_time
    end

    def part2(input)
      timestamp, bus_lines = input.split("\n")
      bus_numbers = bus_lines.split(",").each_with_index.reject { |bus, index| bus == "x" }
                             .map { |bus, index| [bus.to_i, index] }

      highest_bus = bus_numbers.max_by { |bus, _index| bus }

      increment = highest_bus.first
      timestamp = highest_bus.inject(&:-)
      cached_timestamps = {}
      loop do
        aligned_buses = aligned_buses(bus_numbers, timestamp)
        break if aligned_buses.size == bus_numbers.size

        cached_timestamp = cached_timestamps[aligned_buses]
        if cached_timestamp.nil?
          puts "#{timestamp}: First alignment for #{aligned_buses.inspect}"
          cached_timestamps[aligned_buses] = [timestamp]
        elsif cached_timestamp.size == 1
          puts "#{timestamp}: Second alignment for #{aligned_buses.inspect}"
          cached_timestamps[aligned_buses].prepend(timestamp)
          increment = cached_timestamps[aligned_buses].inject(&:-)
          puts "Updated increment to #{increment}"
        end

        timestamp += increment
        # print_deltas(timestamp, bus_numbers)
      end

      timestamp
    end

    def aligned_buses(bus_numbers, timestamp)
      bus_numbers.select { |bus, index| (timestamp + index) % bus == 0 }
    end

    def print_deltas(timestamp, bus_numbers)
      print "#{timestamp} //"
      bus_numbers.each do |bus, index|
        print "Bus #{bus} : #{sprintf("%3d", timestamp - (timestamp / bus) * bus + index)}  "
      end
      print "\n"
    end
  end
end
