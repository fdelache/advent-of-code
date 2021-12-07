module Year2021
  class Day06
    class LanternFishes
      def initialize(input)
        @fishes = input.split(",").map(&:to_i).tally
      end

      def cycle
        @fishes = @fishes.each_with_object(Hash.new(0)) do |(age, count), memo|
          if age == 0
            memo[8] = count
            memo[6] += count
          else
            memo[age - 1] += count
          end
        end
      end

      def count
        @fishes.map(&:last).sum
      end
    end

    def part1(input)
      lanternfishes = LanternFishes.new(input)
      80.times do
        lanternfishes.cycle
      end

      lanternfishes.count
    end

    def part2(input)
      lanternfishes = LanternFishes.new(input)
      256.times do
        lanternfishes.cycle
      end

      lanternfishes.count
    end
  end
end
