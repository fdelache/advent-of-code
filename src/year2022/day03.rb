module Year2022
  class Day03
    def part1(input)
      input.split("\n")
        .map { partition(_1) }
        .map { common_char(_1, _2) }
        .map { priority(_1) }
        .sum
    end

    def part2(input)
      input.split("\n")
        .each_slice(3)
        .map { common_char(_1, _2, _3) }
        .map { priority(_1) }
        .sum
    end

    private

    def partition(line)
      first = line[0..(line.length / 2 - 1)]
      second = line[(line.length / 2)..-1]
      [first, second]
    end

    def common_char(first, *others)
      common_chars = first.chars.intersection(*others.map(&:chars))
      common_chars.first
    end

    def priority(item)
      if item.ord <= "Z".ord
        item.ord - "A".ord + 27
      else
        item.ord - "a".ord + 1
      end
    end
  end
end
