module Year2020
  class Day15
    def part1(input)
      numbers = input.split(",").map(&:to_i)
      spoken = [nil]
      turn = 1
      numbers.each do |num|
        spoken[turn] = num
        turn += 1
      end

      until turn == 2021
        if spoken[1..-2].include?(spoken.last)
          previous_spoken = spoken[1..-2].rindex(spoken.last)
          spoken << (turn - 1 - previous_spoken - 1)
        else
          spoken << 0
        end

        turn += 1
      end

      spoken.last
    end

    def part2(input)
      numbers = input.split(",").map(&:to_i)
      cache = {}
      turn = 1
      numbers[0..-2].each do |num|
        cache[num] = turn
        turn += 1
      end

      spoken = numbers.last
      until turn == 30000000
        last_turn = cache[spoken]
        cache[spoken] = turn
        spoken = if last_turn.nil?
          0
        else
          turn - last_turn
        end

        turn += 1
      end

      spoken
    end
  end
end
