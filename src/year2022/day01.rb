module Year2022
  class Day01
    def part1(input)
      input.split("\n").map(&:to_i).slice_after(&:zero?).map(&:sum).max
    end

    def part2(input)
      input.split("\n").map(&:to_i).slice_after(&:zero?).map(&:sum).max(3).sum
    end
  end
end
