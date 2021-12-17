module Shared
  module AStar
    class Graph
      # Returns the cost from node to node
      def cost(from, to); end

      # Returns array of the neighbours node of a node
      def neighbours(_node); end

      # Returns array of all the graph nodes
      def all_nodes; end

      # Returns an approximation of the distance between from and to nodes
      def heuristic(from, to); end
    end

    def self.shortest_path(graph, start_node, end_node)
      previous = {}
      discovered_nodes = []
      discovered_nodes << start_node

      path_cost = Hash.new(Float::INFINITY)
      path_cost[start_node] = 0

      estimated_path_cost = Hash.new(Float::INFINITY)
      estimated_path_cost[start_node] = graph.heuristic(start_node, end_node)

      until discovered_nodes.empty?
        node = discovered_nodes.min_by { |node| estimated_path_cost[node] }

        break if node == end_node

        discovered_nodes.delete(node)

        graph.neighbours(node).each do |neighbour|
          tentative_cost = path_cost[node] + graph.cost(node, neighbour)
          if tentative_cost < path_cost[neighbour]
            previous[neighbour] = node
            path_cost[neighbour] = tentative_cost
            estimated_path_cost[neighbour] = tentative_cost + graph.heuristic(neighbour, end_node)
            discovered_nodes << neighbour unless discovered_nodes.include?(neighbour)
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
