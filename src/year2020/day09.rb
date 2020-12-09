module Year2020
  class Day09
    def initialize(preambule_size: 25)
      @preambule_size = preambule_size
    end

    def contains_sum(numbers, sum_to_find)
      numbers.combination(2).map(&:sum).find { |sum| sum_to_find == sum }
    end

    def part1(input)
      sequence = input.split("\n").map(&:to_i)

      preambule = sequence[0..@preambule_size]
      index = @preambule_size

      while contains_sum(preambule, sequence[index])
        preambule = preambule.drop(1)
        preambule << sequence[index]
        index += 1
      end

      sequence[index]
    end

    def encryption_weakness(numbers)
      sorted_numbers = numbers.sort
      sorted_numbers.first + sorted_numbers.last
    end

    def part2(input)
      sum_number = part1(input)
      sequence = input.split("\n").map(&:to_i)

      continuous_sequence = []
      (0..sequence.size).each do |index|
        length = 2
        while (index + length) < sequence.size
          temporary_sum = sequence[index..length].sum
          if temporary_sum == sum_number
            continuous_sequence = sequence[index..length]
            break
          end
          length += 1
        end
      end

      encryption_weakness(continuous_sequence)
    end
  end
end
