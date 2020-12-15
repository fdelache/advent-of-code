module Year2020
  class Day14
    class Program
      attr_reader :memory, :input

      def initialize(input)
        @input = input
        @memory = {}
      end

      def version1
        execute do |address, value|
          @memory[address] = (value & @and_mask) | @or_mask
        end
      end

      def version2
        execute do |address, value|
          masked_address = address.to_s(2).rjust(36, "0").each_char.zip(@mask.each_char).map do |a, m|
            r = a
            if m == "1" || m == "X"
              r = m
            end
            r
          end.join

          build_masks(masked_address).each do |addr|
            @memory[addr] = value
          end
        end
      end

      def execute
        input.each do |line|
          key, value = line.split(" = ")
          if key == "mask"
            @or_mask = value.tr('X', '0').to_i(2)
            @and_mask = value.tr('X', '1').to_i(2)
            @mask = value
          elsif /mem\[(?<address>\d+)\]/ =~ key
            yield address.to_i, value.to_i
          end
        end
      end

      def build_masks(mask)
        return [mask] if mask&.empty?

        char = mask[0]
        remainder = mask[1..-1]
        if char == 'X'
          build_masks(remainder).map { |m| ["0" + m, "1" + m] }.flatten
        else
          build_masks(remainder).map { |m| char + m }
        end
      end
    end

    def part1(input)
      program = Program.new(input.split("\n"))

      program.version1

      program.memory.values.sum
    end

    def part2(input)
      program = Program.new(input.split("\n"))

      program.version2

      program.memory.values.sum
    end
  end
end
