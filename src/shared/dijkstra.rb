module Shared
  module Dijkstra
    class Graph
      # Returns the cost from node to node
      def cost(from, to); end

      # Returns array of the neighbours node of a node
      def neighbours(_node); end

      # Returns array of all the graph nodes
      def all_nodes; end
    end

    def self.shortest_path(graph, start_node, end_node)
      previous = {}
      distance = {}
      distance[start_node] = 0

      unvisited_nodes = Set.new(graph.all_nodes)

      until unvisited_nodes.empty?
        node = distance.filter { |node, _distance| unvisited_nodes.include?(node) }
                       .min_by(&:last).first

        unvisited_nodes.delete(node)

        break if node == end_node

        graph.neighbours(node).each do |neighbour|
          next unless unvisited_nodes.include?(neighbour)

          new_distance = distance[node] + graph.cost(node, neighbour)
          if !distance.has_key?(neighbour) || new_distance < distance[neighbour]
            distance[neighbour] = new_distance
            previous[neighbour] = node
          end
        end
      end

      path = []
      node = end_node
      until node == start_node
        path.unshift(node)
        node = previous[node]
      end

      path
    end
  end
end
