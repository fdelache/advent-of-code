module Year2021
  class Day17
    class Probe
      def initialize(input)
        /target area: x=(?<min_x>-?\d+)..(?<max_x>-?\d+), y=(?<min_y>-?\d+)..(?<max_y>-?\d+)/ =~ input
        @target_area = [Range.new(min_x.to_i, max_x.to_i), Range.new(min_y.to_i, max_y.to_i)]
      end

      def max_y
        (0..(@target_area[1].min.abs-1)).sum
      end

      def in_target_zone?(position)
        @target_area.zip(position).all? { |target_range, pos| target_range.cover?(pos) }
      end

      def overflown?(position)
        position[0] > @target_area[0].max || position[1] < @target_area[1].min
      end

      def all_velocities
        lower_bound_x = (1..).find { |velocity| (1..velocity).sum >= @target_area[0].min }
        upper_bound_x = @target_area[0].max

        lower_bound_y = @target_area[1].min
        upper_bound_y = max_y

        puts "Need to compute #{(upper_bound_x - lower_bound_x) * (upper_bound_y - lower_bound_y)} potential candidates"
        velocities = []
        (lower_bound_x..upper_bound_x).each do |velocity_x|
          (lower_bound_y..upper_bound_y).each do |velocity_y|
            if positions([velocity_x, velocity_y]).take_while { |position| !overflown?(position) }
                                               .any? { |position| in_target_zone?(position) }
              velocities << [velocity_x, velocity_y]
            end
          end
        end

        velocities.uniq
      end

      def positions(initial_velocity)
        position = [0, 0]
        velocity = initial_velocity

        Enumerator.new do |yielder|
          loop do
            yielder << position
            position = position.zip(velocity).map(&:sum)
            velocity[0] -= 1 unless velocity[0] == 0
            velocity[1] -= 1
          end
        end.lazy
      end
    end

    def part1(input)
      Probe.new(input).max_y
    end

    def part2(input)
      Probe.new(input).all_velocities.count
    end
  end
end
