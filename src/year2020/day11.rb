module Year2020
  class Day11
    EMPTY = 'L'
    OCCUPIED = '#'
    FLOOR = '.'

    class Area
      attr_reader :area

      def initialize(area)
        @area = area
      end

      def cycle_seats
        Area.new(@area.map.with_index do |row, row_index|
          row.map.with_index do |seat, column|
            case seat
            when FLOOR
              FLOOR
            when EMPTY
              if occupied_seats_count(adjacent_area(row_index, column)) == 0
                OCCUPIED
              else
                EMPTY
              end
            when OCCUPIED
              if occupied_seats_count(adjacent_area(row_index, column)) > 4
                EMPTY
              else
                OCCUPIED
              end
            end
          end
        end)
      end

      def cycle_seats_part2
        Area.new(@area.map.with_index do |row, row_index|
          row.map.with_index do |seat, column|
            case seat
            when FLOOR
              FLOOR
            when EMPTY
              if occupied_visible_seats_count(row_index, column) == 0
                OCCUPIED
              else
                EMPTY
              end
            when OCCUPIED
              if occupied_visible_seats_count(row_index, column) >= 5
                EMPTY
              else
                OCCUPIED
              end
            end
          end
        end)
      end

      def occupied_seats_count(area)
        area.sum { |row| row.count { |seat| seat == OCCUPIED } }
      end

      def occupied_visible_seats_count(row, column)
        directions = [-1,0,1].product([-1,0,1]).reject { |direction| direction == [0,0] }
        directions.sum do |delta_x, delta_y|
          current_row = row + delta_x
          current_column = column + delta_y

          visible_seat = until outside_area?(current_row, current_column)
            at_pos = area[current_row][current_column]
            current_row += delta_x
            current_column += delta_y
            break at_pos unless at_pos == FLOOR
          end

          if visible_seat == OCCUPIED
            1
          else
            0
          end
        end
      end

      def outside_area?(row, col)
        row < 0 || row >= area.size || col < 0 || col >= area.first.size
      end

      def adjacent_area(row, column)
        area.select.with_index { |_, index| index.between?(row-1, row+1) }
            .map { |row| row.select.with_index { |_, index| index.between?(column-1, column+1) } }
      end

      def eql?(other_area)
        area.eql?(other_area.area)
      end

      def inspect
        area.map do |line|
          line.join("")
        end.join("\n")
      end
    end

    def part1(input)
      area_array = input.split("\n").map(&:each_char).map(&:to_a)

      area = Area.new(area_array)
      # puts "------"
      # p area

      previous_area = nil
      until previous_area&.eql?(area)
        previous_area = area
        area = area.cycle_seats
        # puts "------"
        # p area
      end

      area.occupied_seats_count(area.area)
    end

    def part2(input)
      area_array = input.split("\n").map(&:each_char).map(&:to_a)

      area = Area.new(area_array)
      # puts "------"
      # p area

      previous_area = nil
      until previous_area&.eql?(area)
        previous_area = area
        area = area.cycle_seats_part2
        # puts "------"
        # p area
      end

      area.occupied_seats_count(area.area)
    end
  end
end
