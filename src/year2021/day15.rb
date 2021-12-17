require_relative '../shared/a_star'

module Year2021
  class Day15
    class Cave < Shared::AStar::Graph
      def initialize(input)
        @chitons = {}
        input.split.each_with_index do |row, x|
          row.each_char.each_with_index do |chiton, y|
            @chitons[[x,y]] = chiton.to_i
          end
        end

        @height = input.split.length
        @width = input.split.first.length
      end

      def node_at(position)
        [position, @chitons[position]] if @chitons.has_key?(position)
      end

      def start_node
        node_at([0, 0])
      end

      def end_node
        node_at([@width -1, @height - 1])
      end

      def cost(from, to)
        to.last
      end

      def heuristic(from, to)
        position_from = from.first
        position_to = to.first

        position_from.zip(position_to).map { |a, b| b - a }.map(&:abs).sum
      end

      def all_nodes
        @chitons.map { |position, risk_level| node_at(position) }
      end

      def neighbours(node)
        position = node.first
        adjascent_positions(position).map { |new_position| node_at(new_position) }
                                     .compact
      end

      def adjascent_positions(position)
        [
          [-1, 0],
          [0, -1],
          [1, 0],
          [0, 1]
        ].map do |dx, dy|
          [position[0] + dx, position[1] + dy]
        end
      end
    end

    class CaveExpanded < Cave
      def initialize(input)
        @chitons = {}
        original_width = input.split.length
        original_height = input.split.first.length

        input.split.each_with_index do |row, x|
          row.each_char.each_with_index do |chiton, y|
            5.times do |dx|
              5.times do |dy|
                risk_level = chiton.to_i + dx + dy
                risk_level = risk_level % 9 if risk_level > 9
                @chitons[[dx * original_width + x, dy * original_height + y]] = risk_level
              end
            end
          end
        end

        @height = input.split.length * 5
        @width = input.split.first.length * 5
      end
    end

    def part1(input)
      cave = Cave.new(input)
      path = Shared::AStar.shortest_path(cave, cave.start_node, cave.end_node)
      path.map(&:last).sum
    end

    def part2(input)
      cave = CaveExpanded.new(input)
      path = Shared::AStar.shortest_path(cave, cave.start_node, cave.end_node)
      path.map(&:last).sum
    end
  end
end
