module Year2021
  class Day20
    class Image
      def self.parse(text)
        pixels = {}
        text.split.each_with_index do |row, y|
          row.chars.each_with_index do |pixel, x|
            pixels[[x, y]] = pixel == "#" ? "1" : "0"
          end
        end

        Image.new(pixels)
      end

      attr_reader :pixels

      def initialize(pixels, outside="0")
        @pixels = pixels
        @pixels.default = outside
        min_x, max_x = pixels.keys.map(&:first).minmax
        min_y, max_y = pixels.keys.map(&:last).minmax
        @valid_range_x = Range.new(min_x - 1, max_x + 1)
        @valid_range_y = Range.new(min_y - 1, max_y + 1)
      end

      def outside
        @pixels.default
      end

      def all_positions
        @valid_range_x.flat_map do |x|
          @valid_range_y.map do |y|
            [x, y]
          end
        end
      end

      def nine_pixels_at(position)
        deltas = (-1..1).to_a.repeated_permutation(2).map { |a,b| [b, a] }
        nine_positions = deltas.map { |dx, dy| [position[0] + dx, position[1] + dy] }
        nine_positions.map { |position| @pixels[position] }.join
      end

      def lit_pixel_count
        @pixels.values.count { |v| v == "1" }
      end
    end

    class Algorithm
      attr_reader :mapping

      def initialize(string)
        @mapping = string.chars.map { |s| s == "#" ? "1" : "0" }
      end

      def process(image)
        new_pixels = image.all_positions.inject({}) do |new_image, position|
          output_index = image.nine_pixels_at(position).to_i(2)
          new_image[position] = mapping[output_index]
          new_image
        end
        new_default = mapping[(image.outside * 9).to_i(2)]

        Image.new(new_pixels, new_default)
      end
    end

    def part1(input)
      algorithm, image = input.split("\n\n")
      algorithm = Algorithm.new(algorithm)
      image = Image.parse(image)

      2.times do
        image = algorithm.process(image)
      end

      image.lit_pixel_count
    end

    def part2(input)
      algorithm, image = input.split("\n\n")
      algorithm = Algorithm.new(algorithm)
      image = Image.parse(image)

      50.times do
        image = algorithm.process(image)
      end

      image.lit_pixel_count
    end
  end
end
