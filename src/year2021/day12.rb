module Year2021
  class Day12
    class Graph
      def initialize(input)
        @caves = {}
        input.split.each do |connection|
          a, b = *connection.split('-')
          @caves[a] ||= Cave.new(a)
          @caves[b] ||= Cave.new(b)

          @caves[a].connect_to(@caves[b])
          @caves[b].connect_to(@caves[a])
        end
      end

      def start_cave
        @caves["start"]
      end

      def end_cave
        @caves["end"]
      end

      def paths(&block)
        paths_from(start_cave, &block)
      end

      def paths_from(cave, visited_caves = Hash.new(0), current_path = [], &block)
        visited_caves[cave] += 1
        current_path << cave

        return [current_path] if cave == end_cave

        valid_connected_caves = cave.connected.reject { |c| yield c, visited_caves }
        valid_connected_caves.flat_map do |connected_cave|
          paths_from(connected_cave, visited_caves.dup, current_path.dup, &block)
        end
      end
    end

    class Cave
      def initialize(name)
        @name = name
        @connected = Set.new
      end

      def name
        @name
      end

      def small?
        @name.downcase == @name
      end

      def connect_to(other)
        @connected.add(other)
      end

      def connected
        @connected
      end
    end

    def part1(input)
      cave_unavailable = Proc.new { |cave, visited_caves| cave.small? && visited_caves[cave] == 1 }
      Graph.new(input).paths(&cave_unavailable).count
    end

    def part2(input)
      graph = Graph.new(input)
      cave_unavailable = Proc.new do |cave, visited_caves|
        cave.small? &&
          (visited_caves[cave] > 1 ||
            (visited_caves[cave] == 1 &&
              ([graph.start_cave, graph.end_cave].include?(cave) || visited_caves.any? { |cave, count| cave.small? && count == 2 } )
            )
          )
      end

      graph.paths(&cave_unavailable).count
    end
  end
end
