module Year2020
  class Day12
    class Ship
      def initialize
        @position = [0,0]
        @rotation = 0
        @waypoint = [10, -1]
      end

      def apply_action(action, value)
        case action
        when "N"
          @position[1] -= value
        when "S"
          @position[1] += value
        when "E"
          @position[0] += value
        when "W"
          @position[0] -= value
        when "L"
          @rotation = (@rotation + value) % 360
        when "R"
          @rotation = (@rotation - value) % 360
        when "F"
          case @rotation
          when 0
            @position[0] += value
          when 90
            @position[1] -= value
          when 180
            @position[0] -= value
          when 270
            @position[1] += value
          else
            raise
          end
        end
      end

      def apply_action2(action, value)
        case action
        when "N"
          @waypoint[1] -= value
        when "S"
          @waypoint[1] += value
        when "E"
          @waypoint[0] += value
        when "W"
          @waypoint[0] -= value
        when "L"
          (value / 90).times do
            @waypoint.rotate!
            @waypoint[1] *= -1
          end
        when "R"
          (value / 90).times do
            @waypoint.rotate!
            @waypoint[0] *= -1
          end
        when "F"
          @position[0] += value * @waypoint[0]
          @position[1] += value * @waypoint[1]
        end
      end

      def inspect
        @position.to_s + " " + @waypoint.to_s
      end

      def manhattan_distance
        @position.map(&:abs).inject(&:+)
      end
    end

    def part1(input)
      instructions = input.split("\n")
      ship = Ship.new

      instructions.each do |instruction|
        action = instruction[0]
        value = instruction[1..-1].to_i
        ship.apply_action(action, value)
        p ship
      end

      ship.manhattan_distance
    end

    def part2(input)
      instructions = input.split("\n")
      ship = Ship.new

      instructions.each do |instruction|
        action = instruction[0]
        value = instruction[1..-1].to_i
        ship.apply_action2(action, value)
        p ship
      end

      ship.manhattan_distance
    end
  end
end
