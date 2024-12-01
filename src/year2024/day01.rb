module Year2024
  module ::Enumerable
    def to_i
      map(&:to_i)
    end
  end

  class ::Array
    def distance
      (self[0] - self[1]).abs
    end
  end

  class ::Hash
    def merge_duplicates(other_hash, &block)
      keep_if { |k, _| other_hash.include?(k) }
        .merge(other_hash.keep_if { |k, _| include?(k) }, &block)
    end
  end

  class Day01
    def part1(input)
      first, second = locations(input).map(&:sort)
      first.zip(second).map(&:distance).sum
    end

    def part2(input)
      first, second = locations(input).map(&:tally)
      first.merge_duplicates(second) { |k, v1, v2| k * v1 * v2 }.values.sum
    end

    private

    def locations(input)
      input.lines.map(&:split).transpose.to_i
    end
  end
end
