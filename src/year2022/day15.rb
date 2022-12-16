module Year2022
  class Day15
    class Sensor
      def self.parse(line)
        line.scan(/Sensor at x=(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)/)
          .map { |s_x, s_y, b_x, b_y| new([s_x.to_i, s_y.to_i], [b_x.to_i, b_y.to_i]) }
          .first
      end

      attr_reader :beacon, :sensor

      def initialize(sensor, beacon)
        @sensor = sensor
        @beacon = beacon
      end

      def range_without_beacon(y)
        return nil unless ((sensor[1] - beacon_distance)..(sensor[1] + beacon_distance)).cover?(y)

        ((sensor[0] - (beacon_distance - (sensor[1] - y).abs))..(sensor[0] + (beacon_distance - (sensor[1] - y).abs)))
      end

      private

      def beacon_distance
        sensor.zip(beacon).map { (_1 - _2).abs }.sum
      end

      def merge_range(range1, range2)

      end
    end

    def part1(input, y = 2000000)
      sensors = input.split("\n")
        .map { Sensor.parse(_1) }

      potentially_uncovered = sensors.map { |sensor| sensor.range_without_beacon(y) }
        .map(&:to_a)
        .reduce(&:+)
        .uniq
        .size

      potentially_uncovered - sensors.map(&:beacon).select { _1[1] == y }.uniq.size
    end

    def part2(input, max_y = 4000000)
      sensors = input.split("\n")
        .map { Sensor.parse(_1) }

      beacon_pos = (0..max_y).each do |y|
        detection_zones = sensors.map { |sensor| sensor.range_without_beacon(y) }
          .compact
          .sort_by { _1.min  }
          .reduce([]) do |unified_ranges, range|
            if unified_ranges.empty? || unified_ranges.last.max < (range.min - 1)
              unified_ranges << range
            else
              last = unified_ranges.pop
              unified_ranges << Range.new(last.min, [last.max, range.max].max)
            end
            unified_ranges
          end

        unless detection_zones.size == 1 && detection_zones.first.cover?((0..max_y))
          x = ((0..max_y).to_a - detection_zones.map(&:to_a).reduce(&:+)).first
          break [x, y]
        end
      end

      beacon_pos[0] * 4000000 + beacon_pos[1]
    end
  end
end
