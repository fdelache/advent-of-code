module Year2020
  class Day05
    class Seat
      def initialize(line)
        row = line[0, 7]
        column = line[7, 3]

        @row = row.tr("FB", "01").to_i(2)
        @column = column.tr("RL", "10").to_i(2)
      end

      def seat_id
        @row * 8 + @column
      end
    end

    def part1(input)
      input.split("\n").map { |line| Seat.new(line) }.max_by(&:seat_id).seat_id
    end

    def part2(input)
      seats = input.split("\n").map { |line| Seat.new(line) }
      sorted_seat_ids = seats.sort_by(&:seat_id).map(&:seat_id)
      (sorted_seat_ids.first..sorted_seat_ids.last).to_a - sorted_seat_ids
    end
  end
end
