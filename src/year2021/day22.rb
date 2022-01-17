module Year2021
  class Day22
    class Cuboid
      attr_reader :x_range, :y_range, :z_range

      def initialize(x_range, y_range, z_range)
        @x_range = x_range
        @y_range = y_range
        @z_range = z_range
      end

      def in_initialization_procedure?
        (-50..50).cover?(x_range) && (-50..50).cover?(y_range) && (-50..50).cover?(z_range)
      end

      def hash
        "#{x_range}#{y_range}#{z_range}".hash
      end

      def eql?(other)
        x_range.eql?(other.x_range) && y_range.eql?(other.y_range) && z_range.eql?(other.z_range)
      end

      def size
        x_range.size * y_range.size * z_range.size
      end

      def +(other_cuboid)
        (self.explode + other_cuboid.explode).uniq
      end

      def -(other_cuboid)
        (self.explode - other_cuboid.explode).uniq
      end

      #returns unit cubes from the actual cuboid
      def explode
        exploded_cubes = []
        x_range.each do |x|
          y_range.each do |y|
            z_range.each do |z|
              exploded_cubes << [x, y, z]
            end
          end
        end

        exploded_cubes
      end
    end

    class Step
      def self.parse(line)
        /(?<turn>\w+) x=(?<x_min>-?\d+)..(?<x_max>-?\d+),y=(?<y_min>-?\d+)..(?<y_max>-?\d+),z=(?<z_min>-?\d+)..(?<z_max>-?\d+)/ =~ line
        if turn == "on"
          OnStep.new((x_min.to_i..x_max.to_i), (y_min.to_i..y_max.to_i), (z_min.to_i..z_max.to_i))
        else
          OffStep.new((x_min.to_i..x_max.to_i), (y_min.to_i..y_max.to_i), (z_min.to_i..z_max.to_i))
        end
      end

      attr_reader :cuboid

      def initialize(x_range, y_range, z_range)
        @cuboid = Cuboid.new(x_range, y_range, z_range)
      end

      def initialization_procedure?
        @cuboid.in_initialization_procedure?
      end

      def cubes
        @cubes ||= @cuboid.explode
      end
    end

    class OnStep < Step
      def execute(on_cubes)
        return cubes if on_cubes.empty?

        (cubes + on_cubes).uniq
      end
    end

    class OffStep < Step
      def execute(on_cubes)
        (on_cubes - cubes).uniq
      end
    end

    def part1(input)
      steps = input.split("\n").map { |line| Step.parse(line) }

      on_cuboids = steps.select(&:initialization_procedure?)
                        .inject([]) do |on_cubes, step|
        step.execute(on_cubes)
      end

      on_cuboids.size
    end

    def part2(input)
      steps = input.split("\n").map { |line| Step.parse(line) }

      on_cuboids = []
      steps.each_with_object(on_cuboids) do |step, on_cuboids|
        step.execute(on_cuboids)
      end

      on_cuboids.map(&:size).sum
    end
  end
end
