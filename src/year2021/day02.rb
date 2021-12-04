module Year2021
  class Day02
    def part1(input)
      instructions = input.split("\n").map(&:split)

      position = [0, 0]
      instructions.each do |move, units|
        units = units.to_i
        case move
        when 'forward'
          position[0] += units
        when 'down'
          position[1] += units
        when 'up'
          position[1] -= units
        end
      end

      position.inject(&:*)
    end

    def part2(input)
      instructions = input.split("\n").map(&:split)

      position = [0, 0]
      aim = 0
      instructions.each do |move, units|
        units = units.to_i
        case move
        when 'forward'
          position[0] += units
          position[1] += aim * units
        when 'down'
          aim += units
        when 'up'
          aim -= units
        end
      end

      position.inject(&:*)
    end
  end
end
