module Year2022
  class Day06
    def part1(input)
      find_unique_sequence(input, 4)
    end

    def part2(input)
      find_unique_sequence(input, 14)
    end

    private

    def find_unique_sequence(input, sequence_length)
      input.chars
        .each_cons(sequence_length)
        .find_index { _1.uniq.size == _1.size } + sequence_length
    end
  end
end
