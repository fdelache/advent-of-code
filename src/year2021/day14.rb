module Year2021
  class Day14
    class Rule
      def initialize(rule)
        if /(?<pair>..) -> (?<replacement>.)/ =~ rule
          @pair = pair
          @replacement = replacement
        end
      end

      def pair
        @pair
      end

      def replacement
        @replacement
      end
    end

    class Polymere
      def initialize(input)
        @template, rules = input.split("\n\n")

        @rules = Hash[
          rules.split("\n").map do |rule|
            if /(?<pair>..) -> (?<replacement>.)/ =~ rule
              [pair, replacement]
            end
          end
        ]

        @cache = {}
      end

      def template
        @template
      end

      def tally_pair(pair = template, iteration:)
        cache_key = [pair, iteration]
        return @cache[cache_key] if @cache.has_key?(cache_key)

        return pair.each_char.tally if iteration == 0

        tally = pair.each_char.each_cons(2)
                    .map do |pair|
                      pair_string = pair.join
                      new_string = pair.first + @rules[pair_string] + pair.last
                      tally_pair(new_string, iteration: iteration - 1)
                    end
                    .inject(Hash.new(0)) { |total_tally, tally| merge_tallies(total_tally, tally) }

        tally = remove_tally(tally, pair[1..-2].each_char.tally)

        @cache[cache_key] = tally
        return tally
      end

      def merge_tallies(hash1, hash2)
        hash1.merge(hash2) { |_key, old_value, new_value| old_value + new_value }
      end

      def remove_tally(hash1, hash2)
        hash1.merge(hash2) { |_key, old_value, new_value| old_value - new_value }
      end
    end

    def part1(input, iteration = 10)
      Polymere.new(input).tally_pair(iteration: iteration).values.minmax.reverse.inject(&:-)
    end

    def part2(input)
      Polymere.new(input).tally_pair(iteration: 40).values.minmax.reverse.inject(&:-)
    end
  end
end
