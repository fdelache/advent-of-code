module Year2022
  class Day04
    def part1(input)
      input.split("\n")
        .map { _1.split(",") }
        .map { [range(_1), range(_2)] }
        .select { _1.cover?(_2) || _2.cover?(_1) }
        .count
    end

    def part2(input)
      input.split("\n")
        .map { _1.split(",") }
        .map { [range(_1), range(_2)] }
        .select { intersect?(_1, _2) }
        .count
    end

    private

    def range(textual_range)
      s, e = textual_range.split("-")
      Range.new(s.to_i, e.to_i)
    end

    def intersect?(r1, r2)
      r1.cover?(r2.begin) || r2.cover?(r1.begin)
    end
  end
end
