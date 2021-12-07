module Year2021
  class Day07
    def part1(input)
      initial_position = input.split(",").map(&:to_i)

      median = initial_position.sort[initial_position.length/2]

      initial_position.sum do |pos|
        (median - pos).abs
      end
    end

    def part2(input)
      initial_position = input.split(",").map(&:to_i)

      (initial_position.min..initial_position.max).map do |mean|
        initial_position.sum { |pos| power_distance(pos, mean) }
      end.min
    end

    def power_distance(a, b)
      delta = (a - b).abs
      (delta * (delta + 1)) / 2
    end
  end
end
