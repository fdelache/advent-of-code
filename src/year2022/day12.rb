module Year2022
  class Day12
    class Mountain < Shared::AStar::Graph
      def initialize(input)
        @map = {}
        input.split.each_with_index do |row, x|
          row.each_char.each_with_index do |height, y|
            @map[[x,y]] = height
            if height == 'S'
              @map[[x,y]] = "a"
              @start_position = [x,y]
            elsif height == 'E'
              @map[[x,y]] = "z"
              @end_position = [x,y]
            end
          end
        end
      end

      def node_at(position)
        [position, @map[position]] if @map.has_key?(position)
      end

      def start_node
        node_at(@start_position)
      end

      def end_node
        node_at(@end_position)
      end

      def cost(from, to)
        return 1 if to.last.ord <= (from.last.ord + 1)
        1000
      end

      def heuristic(from, to)
        position_from = from.first
        position_to = to.first

        position_from.zip(position_to).map { |a, b| b - a }.map(&:abs).sum
      end

      def all_nodes
        @map.map { |position, height| node_at(position) }
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

    def part1(input)
      mountain = Mountain.new(input)
      path = Shared::AStar.shortest_path(mountain, mountain.start_node, mountain.end_node)
      path.size
    end

    def part2(input)
      mountain = Mountain.new(input)
      potential_start_nodes = mountain.all_nodes.select { |(position, height)| height == "a" && position[1] == 0 }
      puts "potential_start_nodes: #{potential_start_nodes.size}"
      potential_start_nodes.map do |start_node|
        Shared::AStar.shortest_path(mountain, start_node, mountain.end_node).size
      end.min
    end
  end
end
