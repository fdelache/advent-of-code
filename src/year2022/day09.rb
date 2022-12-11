module Year2022
  class Day09
    DIRECTIONS = {
      "R" => [1, 0],
      "L" => [-1, 0],
      "U" => [0, 1],
      "D" => [0, -1],
    }

    def part1(input)
      visited_tail_positions = Set.new
      visited_tail_positions << [0, 0]

      input.split("\n")
        .reduce([visited_tail_positions, [0,0], [0,0]]) do |(visited_tail_positions, head_position, tail_position), instruction|
          direction, distance = instruction.split(" ")
          distance.to_i.times do
            head_position = head_position.zip(DIRECTIONS[direction]).map(&:sum)
            if rope_stretched?(head_position, tail_position)
              tail_position = head_position.zip(DIRECTIONS[direction]).map { _1.reduce(&:-) }
              visited_tail_positions << tail_position
            end
          end
          [visited_tail_positions, head_position, tail_position]
        end
        .first
        .size
    end

    def part2(input)
      visited_tail_positions = Set.new
      visited_tail_positions << [0, 0]
      current_positions = Array.new(10) { [0, 0] }

      input.split("\n")
        .reduce([visited_tail_positions, current_positions]) do |(visited_tail_positions, knot_positions), instruction|
        direction, distance = instruction.split(" ")

        distance.to_i.times do
          # move head
          knot_positions[0] = knot_positions[0].zip(DIRECTIONS[direction]).map(&:sum)

          (1...knot_positions.length).each do |i|
            break unless rope_stretched?(knot_positions[i-1], knot_positions[i])
            knot_positions[i] = move(knot_positions[i-1], knot_positions[i])

            visited_tail_positions << knot_positions[i] if i == knot_positions.length - 1
          end
        end
        print(knot_positions)
        [visited_tail_positions, knot_positions]
      end

      p visited_tail_positions
      visited_tail_positions.size
    end

    private

    def rope_stretched?(head_position, tail_position)
      head_position.zip(tail_position).map { _1.reduce(&:-).abs }.max > 1
    end

    def move(previous_knot, current_knot)
      [
        current_knot[0] + (previous_knot[0] - current_knot[0]).clamp(-1, 1),
        current_knot[1] + (previous_knot[1] - current_knot[1]).clamp(-1, 1),
      ]
    end

    def print(knot_positions)
      min_x, max_x = knot_positions.map { _1[0] }.minmax
      min_y, max_y = knot_positions.map { _1[1] }.minmax

      output = (max_y..min_y).step(-1).map do |y|
        (min_x..max_x).map do |x|
          knot_positions.index([x, y]) || "."
        end.join
      end.join("\n")

      puts output
      puts
    end
  end
end
