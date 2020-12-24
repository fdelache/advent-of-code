module Year2020
  class Day24
    DIRECTIONS = {
      "e" => [2, 0],
      "se" => [1, 1],
      "sw" => [-1, 1],
      "w" => [-2, 0],
      "nw" => [-1, -1],
      "ne" => [1, -1]
    }

    def move(position, direction)
      deltas = DIRECTIONS[direction]
      position.zip(deltas).map(&:sum)
    end

    def end_position(line)
      pos = [0, 0]
      line.scan(/(e|se|sw|w|nw|ne)/).flatten.each do |direction|
        pos = move(pos, direction)
      end

      pos
    end

    def adjacent_positions(p)
      DIRECTIONS.keys.map { |d| move(p, d) }
    end

    def part1(input)
      lines = input.split("\n")
      black = {}
      lines.each do |l|
        black[end_position(l)] ^= true
      end

      black.values.count { |v| v }
    end

    def day(black_tiles)
      positions_to_inspect = black_tiles.keys.map { |p| adjacent_positions(p) }.flatten(1)
      positions_to_inspect = (positions_to_inspect + black_tiles.keys).uniq

      updated_positions = positions_to_inspect.each_with_object({}) do |p, update|
        adjacent = adjacent_positions(p)
        if black_tiles[p]
          black_adjacent_tiles = adjacent.count { |p| black_tiles[p] }
          update[p] = false if (black_adjacent_tiles == 0 || black_adjacent_tiles > 2)
        else
          black_adjacent_tiles = adjacent.count { |p| black_tiles[p] }
          update[p] = true if black_adjacent_tiles == 2
        end
      end

      black_tiles.merge(updated_positions).compact.reject { |_k, v| v == false }
    end

    def part2(input)
      lines = input.split("\n")
      black_tiles = {}
      lines.each do |l|
        black_tiles[end_position(l)] ^= true
      end
      black_tiles = black_tiles.compact.reject { |_k, v| v == false }

      count = 0
      100.times do |d|
        black_tiles = day(black_tiles)
        count = black_tiles.size
        # puts "Day #{d+1}: #{count}"
      end

      count
    end
  end
end
