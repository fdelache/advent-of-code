module Year2020
  class Day17
    Position = Struct.new(:x, :y, :z, :w)

    class Map
      def initialize(input, dimension = 3)
        @content = {}
        @dimension = dimension
        input.split("\n").each_with_index do |line, y|
          line.each_char.with_index do |c, x|
            @content[Position.new(x, y, 0, 0)] = true if c == '#'
          end
        end
      end

      def active?(position)
        @content.has_key?(position)
      end

      def cycle
        visited_positions = []
        updates = {}

        positions_of_interest.each do |position|
          if active?(position)
            active_neighbours = count_adjacent_actives(position)
            if active_neighbours != 2 && active_neighbours != 3
              updates[position] = nil
            end
          elsif count_adjacent_actives(position) == 3
            updates[position] = true
          end
        end

        @content.merge!(updates).compact!
      end

      def active_count
        @content.size
      end

      def count_adjacent_actives(position)
        adjacent_positions(position).count { |position| active?(position) }
      end

      def positions_of_interest
        @content.each_with_object(Set.new) do |(pos, _active), positions|
          positions.add(pos)
          positions.merge(adjacent_positions(pos))
        end
      end

      def adjacent_positions(position)
        (-1..1).to_a.repeated_permutation(@dimension).reject { |deltas| deltas.all?(&:zero?) }.map do |deltas|
          dx, dy, dz, dw = deltas
          Position.new(position.x + dx, position.y + dy, position.z + dz, position.w + dw.to_i)
        end
      end

      def inspect
        min_x, max_x = @content.keys.map(&:x).minmax
        min_y, max_y = @content.keys.map(&:y).minmax
        min_z, max_z = @content.keys.map(&:z).minmax
        min_w, max_w = @content.keys.map(&:w).minmax

        output = ""
        (min_w..max_w).each do |w|
          (min_z..max_z).each do |z|
            output += "z=#{z}, w=#{w}\n"
            (min_y..max_y).each do |y|
              (min_x..max_x).each do |x|
                output += active?(Position.new(x, y, z)) ? "#" : "."
              end
              output += "\n"
            end
            output += "\n"
          end
        end

        output
      end
    end

    def part1(input)
      map = Map.new(input)
      p map

      6.times do |cycle|
        map.cycle

        # puts "After #{cycle + 1} cycle:"
        # p map
      end

      map.active_count
    end

    def part2(input)
      map = Map.new(input, 4)
      p map

      6.times do |cycle|
        map.cycle

        # puts "After #{cycle + 1} cycle:"
        # p map
      end

      map.active_count
    end
  end
end
