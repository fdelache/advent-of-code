module Year2020
  class Day10
    def part1(input)
      adapters = input.split("\n").map(&:to_i).sort

      built_in = adapters.max + 3
      source = [0] + adapters.dup
      source.zip(adapters + [built_in]).map { |a, b| b - a }.partition { |delta| delta < 3 }.map(&:count).inject(&:*)
    end

    def part2(input)
      adapters = input.split("\n").map(&:to_i).sort.prepend(0)

      return unless valid_sequence(adapters)
      groups = find_grouped_sequences(adapters)

      groups.map { |group| count_of_valid_combinations(group) }.inject(&:*)
    end

    def find_grouped_sequences(adapters)
      adapters.each_with_object([]) do |adapter, memo|
        if memo.last.nil?
          memo << [adapter]
        else
          last_group = memo.last
          if last_group.max > (adapter - 3)
            last_group << adapter
          else
            memo << [adapter]
          end
        end
      end.reject { |group| group.size < 3 }
    end

    def count_of_valid_combinations(group)
      interior = group[1..-2]
      (interior.size + 1).times.map do |size|
        interior.combination(size).to_a
      end.flatten(1).map { |interior_combination| interior_combination.prepend(group[0]).append(group[-1]) }
              .select { |combination| valid_sequence(combination) }
              .count
    end

    def valid_sequence(sequence)
      if sequence.size > 2
        sequence[0..-2].zip(sequence[1..-1]).map { |a, b| b - a }.none? { |delta| delta > 3 }
      else
        sequence.reverse.inject(&:-) <= 3
      end
    end
  end
end
