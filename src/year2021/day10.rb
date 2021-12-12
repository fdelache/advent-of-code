module Year2021
  class Day10
    class Chunk
      VALID_CHARS = {
        '(' => ')',
        '[' => ']',
        '{' => '}',
        '<' => '>'
      }

      def initialize(chunk_char)
        @chunk_char = chunk_char
      end

      def closing_char?(c)
        closing_char == c
      end

      def closing_char
        VALID_CHARS[@chunk_char]
      end
    end

    class Line
      CHAR_SCORE = {
        ')' => 1,
        ']' => 2,
        '}' => 3,
        '>' => 4
      }

      def initialize(content)
        @content = content
        @chunks = []
        @invalid_char = nil
        build_chunks
      end

      def invalid_char
        @invalid_char
      end

      def corrupted?
        invalid_char != nil
      end

      def completion_score
        completion_string.each_char.inject(0) do |total_score, char|
          total_score * 5 + CHAR_SCORE[char]
        end
      end

      def completion_string
        @chunks.reverse.map(&:closing_char).join
      end

      def build_chunks
        @content.each_char do |c|
          if opening_char?(c)
            @chunks << Chunk.new(c)
          else
            chunk = @chunks.pop
            if !chunk.closing_char?(c)
              @invalid_char = c
              break
            end
          end
        end
      end

      def opening_char?(c)
        ['(', '[', '{', '<'].include?(c)
      end
    end

    def score(char)
      case char
      when ')'
        3
      when ']'
        57
      when '}'
        1197
      when '>'
        25137
      end
    end

    def part1(input)
      lines = input.split.map { |l| Line.new(l) }
      lines.select(&:corrupted?)
           .map(&:invalid_char)
           .map { |c| score(c) }
           .sum
    end

    def part2(input)
      lines = input.split.map { |l| Line.new(l) }
      scores = lines.reject(&:corrupted?)
           .map(&:completion_score)
           .sort

      scores[scores.length/2]
    end
  end
end
