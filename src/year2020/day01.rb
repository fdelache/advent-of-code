module Year2020
  class Day01
    def part1(input)
      numbers = input.split("\n").map(&:to_i)
      found = numbers.combination(2).find { |a,b| a + b == 2020 }
      found[0] * found[1]
    end

    def part2(input)
      numbers = input.split("\n").map(&:to_i)
      found = numbers.combination(3).find { |a,b,c| a + b + c == 2020 }
      found[0] * found[1] * found[2]
    end
  end
end
