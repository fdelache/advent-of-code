module Year2021
  class Day09
    class HeightMap
      class Location
        def initialize(height)
          @height = height
        end

        def height
          @height
        end

        def risk_level
          @height + 1
        end
      end

      def initialize(input)
        @map = Hash.new

        input.split("\n").each_with_index do |row, x|
          row.each_char.each_with_index do |location, y|
            @map[[x,y]] = Location.new(location.to_i)
          end
        end
      end

      def lowest_points
        @map.filter do |position, location|
          adjascent_locations = adjascent_positions(*position).map { |p| @map[p] }.compact
          adjascent_locations.all? { |adjascent| adjascent.height > location.height }
        end
      end

      def find_basin(point, basin_points = [])
        return unless @map[point]
        return if @map[point].height == 9

        basin_points << point
        adjascent_positions(*point).reject { |p| basin_points.include?(p) }
                                   .each { |p| find_basin(p, basin_points) }

        basin_points.uniq
      end

      def adjascent_positions(x, y)
        [[x-1, y], [x+1, y], [x,y-1], [x, y+1]]
      end
    end

    def part1(input)
      height_map = HeightMap.new(input)
      height_map.lowest_points.values.sum(&:risk_level)
    end

    def part2(input)
      height_map = HeightMap.new(input)
      height_map.lowest_points.map { |p, l| height_map.find_basin(p) }
                .map(&:length)
                .sort
                .last(3)
                .inject(&:*)
    end
  end
end
