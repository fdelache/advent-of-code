require 'matrix'

module Year2021
  class Day19
    class Vector
      attr_reader :deltas
      def initialize(point1, point2)
        @deltas = point1.zip(point2).map { |p1, p2| p2 - p1 }
        @point1 = point1
        @point2 = point2
      end

      def eql?(other_vector)
        deltas == other_vector.deltas || deltas.map { |d| d * -1 } == other_vector.deltas
      end
    end

    class Scanner
      def self.parse(input)
        lines = input.split("\n")
        /--- scanner (?<scanner_id>\d+) ---/ =~ lines.shift

        beacons = lines.map do |beacon|
          /(?<x>-?\d+),(?<y>-?\d+),(?<z>-?\d+)/ =~ beacon
          [x.to_i, y.to_i, z.to_i]
        end

        Scanner.new(scanner_id.to_i, beacons)
      end

      IDENTITY = Proc.new { |point| point }

      attr_reader :id, :beacons

      def initialize(scanner_id, beacons, transform = IDENTITY)
        @id = scanner_id
        @beacons = beacons.map { |beacon| transform.call(beacon) }
      end

      def rotate(axis)
        Proc.new do |point|
          new_point = []
          new_point[axis] = point[axis]
          new_point[(axis - 1) % 3] = point[(axis + 1) % 3]
          new_point[(axis + 1) % 3] = -point[(axis - 1) % 3]
          new_point
        end
      end

      def all_transform_scanners
        rot_x = rotate(0)
        rot_y = rotate(1)
        rot_z = rotate(2)

        [
          # facing x-positive
          IDENTITY,
          rot_x,
          rot_x >> rot_x,
          rot_x >> rot_x >> rot_x,
          # facing y-positive
          rot_z,
          rot_z >> rot_x,
          rot_z >> rot_x >> rot_x,
          rot_z >> rot_x >> rot_x >> rot_x,
          # facing x-negative
          rot_z >> rot_z,
          rot_z >> rot_z >> rot_x,
          rot_z >> rot_z >> rot_x >> rot_x,
          rot_z >> rot_z >> rot_x >> rot_x >> rot_x,
          # facing y-negative
          rot_z >> rot_z >> rot_z,
          rot_z >> rot_z >> rot_z >> rot_x,
          rot_z >> rot_z >> rot_z >> rot_x >> rot_x,
          rot_z >> rot_z >> rot_z >> rot_x >> rot_x >> rot_x,
          # facing z-positive
          rot_y,
          rot_y >> rot_x,
          rot_y >> rot_x >> rot_x,
          rot_y >> rot_x >> rot_x >> rot_x,
          # facing z-negative
          rot_y >> rot_y >> rot_y,
          rot_y >> rot_y >> rot_y >> rot_x,
          rot_y >> rot_y >> rot_y >> rot_x >> rot_x,
          rot_y >> rot_y >> rot_y >> rot_x >> rot_x >> rot_x,
        ].map { |transform| Scanner.new(id, @beacons, transform) }
      end

      def matches(reference_scanner)
        !translation_vector(reference_scanner).nil?
      end

      def translation_vector(reference_scanner)
        @translation_vector ||= begin
          reference_scanner.beacons.flat_map { |ref_beacon| beacons.map { |beacon| ref_beacon.zip(beacon).map { |r, b| r - b } } }
                           .tally
                           .select { |_vector, count| count >= 12 }
                           .map(&:first)
                           .first
        end
      end

      def add_beacons(other_scanner)
        translated_beacons = other_scanner.beacons.map { |beacon| other_scanner.translation_vector(self).zip(beacon).map(&:sum) }
        @beacons += translated_beacons
        @beacons.uniq!
      end
    end

    def part1(input)
      scanners = input.split("\n\n")
                      .map { |text| Scanner.parse(text) }

      scanner_0 = scanners.shift
      scanners = scanners.flat_map(&:all_transform_scanners)
      until scanners.empty? do
        matching_scanner = scanners.find { |scanner| scanner.matches(scanner_0) }
        scanners.reject! { |scanner| scanner.id == matching_scanner.id }
        scanner_0.add_beacons(matching_scanner)
      end

      scanner_0.beacons.size
    end

    def part2(input)
      scanners = input.split("\n\n")
                      .map { |text| Scanner.parse(text) }

      scanner_0 = scanners.shift
      scanners = scanners.flat_map(&:all_transform_scanners)
      matching_scanners = []
      until scanners.empty? do
        matching_scanner = scanners.find { |scanner| scanner.matches(scanner_0) }
        scanners.reject! { |scanner| scanner.id == matching_scanner.id }
        scanner_0.add_beacons(matching_scanner)
        matching_scanners << matching_scanner
      end

      matching_scanners.map { |scanner| scanner.translation_vector(scanner_0) }
                       .combination(2)
                       .map { |v1, v2| manhattan_distance(v1, v2) }
                       .max
    end

    def manhattan_distance(v1, v2)
      v1.zip(v2).map { |p1, p2| (p2 - p1).abs }.sum
    end
  end
end
