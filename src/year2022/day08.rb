module Year2022
  class Day08
    class Forest

      DIRECTIONS = {
        up: [0, -1],
        down: [0, 1],
        left: [-1, 0],
        right: [1, 0],
      }

      def self.parse(input)
        new(input.split("\n")
          .map { _1.each_char.map(&:to_i) })
      end

      def initialize(trees)
        @trees = trees.each_with_index.reduce({}) do |trees, (row, y)|
          row.each_with_index do |tree, x|
            trees[[x, y]] = tree
          end
          trees
        end
      end

      def max_score
        @trees.select { |k, v| v > 0 }
          .keys.map { score(_1) }.max
      end

      def score(position)
        DIRECTIONS.values.map do |(dx, dy)|
          visible_trees(position, dx, dy)
        end
          .reduce(&:*)
      end

      def visible_trees(position, dx, dy)
        x, y = position
        visible_count = 0
        tree_height = @trees[position]
        loop do
          x += dx
          y += dy
          visible_count += 1 unless @trees[[x, y]].nil?
          break if @trees[[x, y]].nil? || @trees[[x, y]] >= tree_height
        end
        visible_count
      end
    end

    def part1(input)
      trees_height = input.split("\n")
        .map { _1.each_char.map(&:to_i) }

      visible_trees = Set.new
      trees_height.map.each_with_index do |row, i|
        base_height = -1
        row.each_with_index do |tree, j|
          if tree > base_height
            visible_trees << [i, j]
            base_height = tree
          end
        end

        base_height = -1
        row.reverse.each_with_index do |tree, j|
          if tree > base_height
            visible_trees << [i, row.length - j - 1]
            base_height = tree
          end
        end
      end

      trees_height.transpose.map.each_with_index do |column, j|
        base_height = -1
        column.each_with_index do |tree, i|
          if tree > base_height
            visible_trees << [i, j]
            base_height = tree
          end
        end

        base_height = -1
        column.reverse.each_with_index do |tree, i|
          if tree > base_height
            visible_trees << [column.length - i - 1, j]
            base_height = tree
          end
        end
      end

      visible_trees.size
    end

    def part2(input)
      Forest.parse(input).max_score
    end
  end
end
