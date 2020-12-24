module Year2020
  class Day20
    class Tile
      attr_reader :id, :content, :north, :south, :east, :west, :sides

      NORTH = 0
      SOUTH = 1
      EAST = 2
      WEST = 3

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
        _matching_side, matching_index = sides.each_with_index.find do |side, _index|
          other_tile.sides.include?(side) || other_tile.sides.include?(side.reverse)
        end

        matching_index
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

      def each_transformation
        Enumerator.new do |y|
          transformations = [:rotate, :flip_v, :rotate, :flip_h, :rotate, :flip_v, :rotate, :flip_h]
          transformations.each do |m|
            self.send(m)
            y << self
          end
        end
      end

      def inside
        content[1..-2].map { |s| s[1..-2] }
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

      def find_adjacent(tile)
        tiles.reject { |other| other == tile }
             .select { |other| tile.matching_side?(other) }
      end

      def assemble
        corners = find_corners

        map_size = Math.sqrt(tiles.size)
        positions = Array.new(map_size) { Array.new(map_size) }
        top_left = corners.first
        adjacent = find_adjacent(top_left)
        top_left.each_transformation.find do |tile|
          matching_orientations = adjacent.map { |a| tile.matching_side_orientation(a) }.sort
          matching_orientations == [Tile::SOUTH, Tile::EAST]
        end

        positions[0][0] = top_left
        previous = top_left

        (0...map_size).each do |y|
          (1...map_size).each do |x|
            next_tile = find_adjacent(previous).find do |t|
              t.each_transformation.any? do |m|
                m.sides[Tile::WEST] == previous.sides[Tile::EAST]
              end
            end
            positions[y][x] = next_tile
            previous = next_tile
          end

          previous = positions[y][0]
          next_tile = find_adjacent(previous).find do |t|
            t.each_transformation.any? do |m|
              m.sides[Tile::NORTH] == previous.sides[Tile::SOUTH]
            end
          end
          positions[y+1][0] = next_tile unless y == (map_size-1)
          previous = next_tile
        end

        BigMap.new(positions, map_size)
      end
    end

    class BigMap < Tile
      attr_reader :map_size

      def initialize(tile_positions, map_size)
        content = (0...map_size).map do |y|
          (0...map_size).map do |x|
            tile_positions[y][x].inside
          end.transpose.map(&:join)
        end.flatten
        super(0, content)
        @map_size = content.size
      end

      def count_sea_monsters
        (1...(map_size-1)).sum do |y|
          (0..(map_size-20)).count do |x|
            sea_monster_at?(x, y)
          end
        end
      end

      def max_sea_monsters
        each_transformation.map(&:count_sea_monsters).max
      end

      def sea_monster_at?(x, y)
        return false unless content[y][x..-1].match?(/^#.{4}##.{4}##.{4}###/)
        return false unless content[y-1][x+18] == "#"
        content[y+1][x..-1].match?(/^.#..#..#..#..#..#/)
      end

      def water_roughness
        count = @content.sum do |row|
          row.each_char.count { |c| c == "#" }
        end

        count - max_sea_monsters * 15
      end
    end

    def part1(input)
      map = Map.parse(input)
      corners = map.find_corners

      corners.map(&:id).inject(&:*)
    end

    def part2(input)
      map = Map.parse(input)
      big_map = map.assemble
      big_map.water_roughness
    end
  end
end
