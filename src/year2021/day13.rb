module Year2021
  class Day13
    class HorizontalFold
      def initialize(line)
        @line = line
      end

      def transform(paper)
        new_paper = []
        paper.each do |x, y|
          if y > @line
            new_paper << [x, 2 * @line - y]
          else
            new_paper << [x, y]
          end
        end

        new_paper.uniq
      end
    end

    class VerticalFold
      def initialize(line)
        @line = line
      end

      def transform(paper)
        new_paper = []
        paper.each do |x, y|
          if x > @line
            new_paper << [2 * @line - x, y]
          else
            new_paper << [x, y]
          end
        end

        new_paper.uniq
      end
    end

    class Paper
      def initialize(input)
        @paper = []
        @fold_instructions = []
        input.split("\n").each do |line|
          if /(?<x>\d+),(?<y>\d+)/ =~ line
            @paper << [x.to_i, y.to_i]
          elsif /fold along y=(?<horizontal>\d+)/ =~ line
            @fold_instructions << HorizontalFold.new(horizontal.to_i)
          elsif /fold along x=(?<vertical>\d+)/ =~ line
            @fold_instructions << VerticalFold.new(vertical.to_i)
          end
        end
      end

      def dot_count
        @paper.length
      end

      def fold_once
        first_instruction = @fold_instructions.shift
        @paper = first_instruction.transform(@paper)
      end

      def fold
        @paper = @fold_instructions.inject(@paper) do |paper, instruction|
          instruction.transform(paper)
        end
      end

      def print
        width = @paper.map { |x, _y| x }.max
        height = @paper.map { |_x, y| y }.max

        (0..height).each do |y|
          (0..width).each do |x|
            char = @paper.include?([x,y]) ? "#" : "."
            putc char
          end
          puts
        end
      end
    end

    def part1(input)
      paper = Paper.new(input)
      paper.fold_once
      paper.dot_count
    end

    def part2(input)
      paper = Paper.new(input)
      paper.fold
      paper.print
    end
  end
end
