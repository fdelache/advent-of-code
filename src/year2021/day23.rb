module Year2021
  class Day23
    #############
    #...........#
    ###D#D#B#A###
      #C#A#B#C#
      #########

    class Node
      def initialize(content = nil)
        @content = content
        @edges = []
      end

      def add_edge_node(node)
        @edges << node
        self
      end

      def available?
        @content.nil?
      end
    end

    def part1(input)
      hallway = 11.times.inject(Node.new) do |memo, i|
        new_node = Node.new
        memo.add_edge_node(new_node)
        new_node
      end

      room1 = Node.new("C").add_edge_node(Node.new("D"))
      room2 = Node.new("A").add_edge_node(Node.new("D"))
      room3 = Node.new("B").add_edge_node(Node.new("B"))
      room4 = Node.new("C").add_edge_node(Node.new("A"))

    end

    def part2(input)
      nil
    end
  end
end
