module Year2022
  class Day10
    def part1(input)
      input.split("\n")
        .reduce([1, 1]) do |cycles, line|
          case line
          when /noop/
            cycles << cycles.last
          when /addx ([-]?\d+)/
            cycles << cycles.last
            cycles << cycles.last + $1.to_i
          end
          cycles
        end
        .each_with_index
        .select { |_x, index| [20, 60, 100, 140, 180, 220].include?(index) }
        .map { |x, index| index * x }
        .sum
    end

    def part2(input)
      output = input.split("\n")
        .reduce([1, 1]) do |cycles, line|
          case line
          when /noop/
            cycles << cycles.last
          when /addx ([-]?\d+)/
            cycles << cycles.last
            cycles << cycles.last + $1.to_i
          end
          cycles
        end
        .each_with_index
        .map do |x, index|
          if index == 0
            ""
          elsif ((x - 1)..(x+1)).include?((index - 1) % 40)
            "#"
          else
            "."
          end
      end
        .drop(1)
        .each_slice(40)
        .map { _1.join }
        .join("\n")

      puts output
    end
  end
end
