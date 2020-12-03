module Year2020
  class Day03
    class Map
      def initialize(lines)
        @map = lines
        @width = lines[0].size
        @height = lines.count
      end

      def tree_at?(position)
        wrapped_position = wrap_position(position)
        @map[wrapped_position[1]][wrapped_position[0]] == '#'
      end

      def outside_map?(position)
        position[1] >= @height
      end

      def wrap_position(position)
        [position[0] % @width, position[1]]
      end
    end

    SLOPES = [
      [1, 1],
      [3, 1],
      [5, 1],
      [7, 1],
      [1, 2]
    ].freeze

    def next_position(position, slope=[3, 1])
      [position[0] + slope[0], position[1] + slope[1]]
    end

    def part1(input)
      map = Map.new(input.split("\n"))
      trees_count(map, [3, 1])
    end

    def part2(input)
      map = Map.new(input.split("\n"))
      SLOPES.map { |slope| trees_count(map, slope) }
            .inject(&:*)
    end

    def trees_count(map, slope)
      position = [0, 0]
      trees_encountered = 0
      until map.outside_map?(position)
        trees_encountered += 1 if map.tree_at?(position)
        position = next_position(position, slope)
      end

      trees_encountered
    end
  end
end
