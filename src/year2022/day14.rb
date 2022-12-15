module Year2022
  class Day14
    class Cave
      def self.parse(input, with_floor: false)
        rocks = input.each_line
          .reduce([]) { |rocks, line| rocks.push(*rock_positions(line)) }

        Cave.new(rocks, with_floor)
      end

      def self.rock_positions(line)
        line.scan(/(\d+),(\d+)/).each_cons(2).reduce([]) do |rocks, positions|
          x_range, y_range = positions.transpose.map { _1.map(&:to_i) }.map(&:sort)
          Range.new(*x_range).each do |x|
            Range.new(*y_range).each do |y|
              rocks << [x, y]
            end
          end
          rocks
        end
      end

      def initialize(rocks, with_floor)
        @cave = rocks.each_with_object({}) { |position, cave| cave[position] = :rock }
        @max_y = @cave.keys.map(&:last).max
        if with_floor
          @max_y += 2
          min_x, max_x = @cave.keys.map(&:first).minmax
          ((min_x-@max_y-2)..(max_x+@max_y+2)).each { @cave[[_1, @max_y]] = :rock }
        end
      end

      def fill_with_sand
        while drop_sand
          if count_sand % 100 == 0
            puts "New drop - #{count_sand}"
            p self
          end
        end
      end

      def count_sand
        @cave.count { _2 == :sand }
      end

      def inspect
        min_x, max_x, min_y, max_y = @cave.keys.transpose.flat_map(&:minmax)
        (min_y..max_y).map do |y|
          (min_x..max_x).map do |x|
            case @cave[[x,y]]
            when :rock
              '#' #'🪨'
            when :sand
              'o' #'🟠'
            else
              ' '
            end
          end.join
        end.join("\n")
      end

      private

      def drop_sand(position = [500,0])
        rested = loop do
          new_position = move(position)
          break true if position == new_position
          break false if new_position[1] > @max_y
          position = new_position
        end

        if rested
          @cave[position] = :sand
          @last_position = position
        end
        rested && position != [500,0]
      end

      POSSIBLE_MOVES = [
        [0, 1],
        [-1, 1],
        [1, 1],
      ]

      def move(position)
        potential_new_positions = POSSIBLE_MOVES.map { |delta| position.zip(delta).map(&:sum) }
        new_position = potential_new_positions.find { !@cave.key?(_1) }
        new_position || position
      end
    end

    def part1(input)
      cave = Cave.parse(input)
      cave.fill_with_sand
      cave.count_sand
    end

    def part2(input)
      cave = Cave.parse(input, with_floor: true)
      cave.fill_with_sand
      cave.count_sand
    end
  end
end
