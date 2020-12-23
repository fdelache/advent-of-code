module Year2020
  class Day20
    class Tile
      attr_reader :id, :content, :north, :south, :east, :west, :sides

      def self.parse(tile_data)
        lines = tile_data.split("\n")
        /Tile (?<id>\d+):/ =~ lines.shift

        Tile.new(id.to_i, lines)
      end

      def initialize(id, lines)
        @id = id
        self.content = lines
      end

      def matching_side?(other_tile)
        sides.any? do |side|
          other_tile.sides.include?(side) || other_tile.sides.include?(side.reverse)
        end
      end

      def matching_side_orientation(other_tile)
        matching_side = sides.find do |side|
          other_tile.sides.include?(side) || other_tile.sides.include?(side.reverse)
        end

        orientations = ""
        matching_sides.each do |s|
          case s
          when north == s
          end
        end
        sides.find_index
      end

      def rotate
        # this does a rotation of 90 degrees clockwise
        self.content = content.map(&:each_char).map(&:to_a)
                              .transpose.map(&:reverse).map(&:join)
      end

      def flip_v
        self.content = content.map { |l| l.reverse }
      end

      def flip_h
        self.content = content.reverse
      end

      private

      def content=(content)
        @content = content
        @north = content.first
        @south = content.last
        @east = content.map { |s| s[-1] }.join
        @west = content.map { |s| s[0] }.join
        @sides = [@north, @south, @east, @west]
      end
    end

    class Map
      attr_reader :tiles

      def self.parse(input)
        tiles_data = input.split("\n\n")
        Map.new(tiles_data.map { |t| Tile.parse(t) })
      end

      def initialize(tiles)
        @tiles = tiles
      end

      def find_corners
        tiles.select do |tile|
          tiles.reject { |other_tile| other_tile == tile }
               .select { |other_tile| tile.matching_side?(other_tile) }
               .count == 2
        end
      end

      def assemble
        corners = find_corners

        map_size = Math.sqrt(tiles.size)
        positions = Array.new(map_size) { Array.new(map_size) }
        positions[0][0] = corners.first
      end
    end

    def part1(input)
      map = Map.parse(input)
      corners = map.find_corners

      corners.map(&:id).inject(&:*)
    end

    def part2(input)
      map = Map.parse(input)
      corners = map.find_corners
    end
  end
end
