module Year2021
  class Day05
    class Point
      attr_reader :x, :y

      def initialize(x, y)
        @x = x
        @y = y
      end

      def eql?(other)
        other.x == x && other.y == y
      end

      def hash
        "#{x}_#{y}".hash
      end

      def to_s
        "(#{x}, #{y})"
      end
    end

    class Line
      def initialize(point1, point2)
        @p1 = point1
        @p2 = point2
      end

      def all_points
        if @p1.x == @p2.x
          ([@p1.y, @p2.y].min..[@p1.y, @p2.y].max).map { |y| Point.new(@p1.x, y) }
        elsif @p1.y == @p2.y
          ([@p1.x, @p2.x].min..[@p1.x, @p2.x].max).map { |x| Point.new(x, @p1.y) }
        else
          dx = @p1.x < @p2.x ? 1 : -1
          dy = @p1.y < @p2.y ? 1 : -1
          (@p1.x..@p2.x).step(dx).zip((@p1.y..@p2.y).step(dy)).map do |x, y|
            Point.new(x, y)
          end
        end
      end

      def diagonal?
        @p1.x != @p2.x && @p1.y != @p2.y
      end

      def to_s
        "#{@p1} -> #{@p2}"
      end
    end

    def lines(input)
      input.split("\n").map do |s|
        if /(?<x1>\d+),(?<y1>\d+) -> (?<x2>\d+),(?<y2>\d+)/ =~ s
          Line.new(Point.new(x1.to_i, y1.to_i), Point.new(x2.to_i, y2.to_i))
        end
      end
    end

    def part1(input)
      cross_count = lines(input).reject(&:diagonal?).flat_map(&:all_points).tally

      cross_count.count { |_p, c| c >= 2 }
    end

    def part2(input)
      cross_count = lines(input).flat_map(&:all_points).tally

      cross_count.count { |_p, c| c >= 2 }
    end
  end
end
