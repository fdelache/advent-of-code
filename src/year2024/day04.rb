module Year2024
  class Day04
    def part1(input)
      Puzzle.new(input)
            .each_cell
            .select(&:is_x?)
            .sum(&:count_xmas_words)
    end

    def part2(input)
      Puzzle.new(input)
            .each_cell
            .select(&:is_a?)
            .count(&:has_x_mas_word?)
    end

    Cell = Data.define(:x, :y, :char, :puzzle) do
      def is_x?
        char == 'X'
      end

      def is_a?
        char == 'A'
      end

      def count_xmas_words
        puzzle.words_at(x, y).count { |word| word == 'XMAS' }
      end

      def has_x_mas_word?
        puzzle.x_words_at(x, y).all? { |word| %w[MAS SAM].include?(word) }
      end
    end

    class Puzzle
      def initialize(input)
        @lines = input.lines.map(&:chomp)
      end

      def each_cell
        return to_enum(__method__) unless block_given?

        lines.each_with_index do |line, y|
          line.each_char.with_index do |char, x|
            yield Cell.new(x, y, char, self)
          end
        end
      end

      def x_words_at(x, y)
        return to_enum(__method__, x, y) unless block_given?

        x_positions = [
          [[x - 1, y - 1], [x, y], [x + 1, y + 1]],
          [[x - 1, y + 1], [x, y], [x + 1, y - 1]]
        ]

        x_positions.each do |pos|
          yield pos.map { |x, y| char_at(x, y) }.join
        end
      end

      def words_at(x, y)
        return to_enum(__method__, x, y) unless block_given?

        positions(x, y).each do |pos|
          yield pos.map { |x, y| char_at(x, y) }.join
        end
      end

      def char_at(x, y)
        return nil unless x.between?(0, @lines[0].size - 1)
        return nil unless y.between?(0, @lines.size - 1)

        @lines[y][x]
      end

      def positions(x, y)
        [
          [[x, y], [x + 1, y], [x + 2, y], [x + 3, y]],
          [[x, y], [x - 1, y], [x - 2, y], [x - 3, y]],
          [[x, y], [x, y - 1], [x, y - 2], [x, y - 3]],
          [[x, y], [x, y + 1], [x, y + 2], [x, y + 3]],
          [[x, y], [x - 1, y - 1], [x - 2, y - 2], [x - 3, y - 3]],
          [[x, y], [x + 1, y - 1], [x + 2, y - 2], [x + 3, y - 3]],
          [[x, y], [x - 1, y + 1], [x - 2, y + 2], [x - 3, y + 3]],
          [[x, y], [x + 1, y + 1], [x + 2, y + 2], [x + 3, y + 3]]
        ]
      end

      private

      attr_reader :lines
    end
  end
end
