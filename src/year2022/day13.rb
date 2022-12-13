class Integer
  alias_method(:old_cmp, :<=>)

  def <=>(other)
    return [self].<=>(other) if other.is_a?(Array)
    old_cmp(other)
  end
end

class Array
  alias_method(:old_cmp, :<=>)

  def <=>(other)
    return self.<=>([other]) if other.is_a?(Integer)
    old_cmp(other)
  end
end

module Year2022
  class Day13
    class Pair
      def self.parse(input)
        left, right = input.split("\n")
        Pair.new(eval(left), eval(right))
      end

      def initialize(left, right)
        @left = left
        @right = right
      end

      def in_order?
        @left.<=>(@right) == -1
      end
    end

    def part1(input)
      input.split("\n\n")
        .map { Pair.parse(_1) }
        .each_with_index
        .select { |p, _i| p.in_order? }
        .map { _2 + 1 }
        .sum
    end

    def part2(input)
      arrays = input.split("\n")
        .reject { _1.empty? }
        .map { eval(_1) }

      divider_packets = [
        [[2]],
        [[6]],
      ]

      arrays.push(*divider_packets)

      arrays.sort
        .each_with_index
        .select { |a, i| divider_packets.include?(a) }
        .map { _2 + 1 }
        .reduce(&:*)
    end
  end
end
