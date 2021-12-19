module Year2021
  class Day18
    class Node
      def self.parse(string_array)
        char = string_array.shift
        left, right, number = nil
        if char == '['
          left = Node.parse(string_array)
          _comma = string_array.shift
          right = Node.parse(string_array)
          _closing_bracket = string_array.shift
        else
          number = char.to_i
        end

        Node.new(left: left, right: right, number: number)
      end

      attr_reader :left, :right, :number

      def initialize(left: nil, right: nil, number: nil)
        @left = left
        @right = right
        @number = number
      end

      def magnitude
        return number if isNumber?
        3 * left.magnitude + 2 * right.magnitude
      end

      def +(other_node)
        new_node = Node.new(left: self, right: other_node)
        new_node.reduce
        new_node
      end

      def add_number(other_number_node)
        @number += other_number_node.number
      end

      def convert_to_number
        @left = nil
        @right = nil
        @number = 0
      end

      def convert_to_pair
        @left = Node.new(number: @number / 2)
        @right = Node.new(number: @number - @left.number)
        @number = nil
      end

      def reduce
        loop do
          changes = false
          explosion_context = [nil, nil, nil]
          fill_explosion_context(1, explosion_context)
          if explosion_context[1]
            left_number = explosion_context[1].left
            right_number = explosion_context[1].right

            explosion_context[0].add_number(left_number) if explosion_context[0]
            explosion_context[2].add_number(right_number) if explosion_context[2]

            explosion_context[1].convert_to_number
            changes = true
          else
            split_node = find_split_node
            if split_node
              split_node.convert_to_pair
              changes = true
            end
          end

          break unless changes
        end
      end

      def isPair?
        number.nil?
      end

      def isNumber?
        !isPair?
      end

      def fill_explosion_context(depth, explosion_context)
        if explosion_context[1].nil?
          if isNumber?
            explosion_context[0] = self
          elsif isPair?
            if depth <= 4
              exploding_node = left.fill_explosion_context(depth + 1, explosion_context)
              explosion_context[1] ||= exploding_node
              exploding_node = right.fill_explosion_context(depth + 1, explosion_context)
              explosion_context[1] ||= exploding_node
            else
              return self
            end
          end
        elsif explosion_context[2].nil?
          if isNumber?
            explosion_context[2] = self
          else
            left.fill_explosion_context(depth + 1, explosion_context)
            right.fill_explosion_context(depth + 1, explosion_context)
          end
        end
        return nil
      end

      def find_split_node
        if isNumber? && number >= 10
          self
        elsif isPair?
          left.find_split_node || right.find_split_node
        end
      end

      def to_s
        return number.to_s if isNumber?
        "[#{left.to_s},#{right.to_s}]"
      end
    end

    def part1(input)
      input.split.map { |line| Node.parse(line.chars) }
           .inject(&:+)
           .magnitude
    end

    def part2(input)
      input.split
           .permutation(2)
           .map { |line1, line2| [Node.parse(line1.chars), Node.parse(line2.chars)] }
           .map { |node1, node2| node1 + node2 }
           .map(&:magnitude)
           .max
    end
  end
end
