module Year2021
  class Day16
    class Packet
      def self.parse(binary_data)
        version = binary_data.shift(3).join
        type = binary_data.shift(3).join

        if type.to_i(2) == 4
          LiteralPacket.parse(version, type, binary_data)
        else
          OperatorPacket.parse(version, type, binary_data)
        end
      end

      def initialize(version, type)
        @version = version.to_i(2)
        @type = type.to_i(2)
      end
    end

    class LiteralPacket < Packet
      def self.parse(version, type, binary_data)
        literal_string = ""

        loop do
          block = binary_data.shift(5)
          msb = block.shift(1).first
          literal_string += block.join
          break if msb == "0"
        end

        LiteralPacket.new(version, type, literal_string)
      end

      def initialize(version, type, literal)
        super(version, type)
        @literal = literal.to_i(2)
      end

      def version_sum
        @version
      end

      def value
        @literal
      end
    end

    class OperatorPacket < Packet
      def self.parse(version, type, binary_data)
        sub_packets = []
        length_type_id = binary_data.shift(1).first
        if length_type_id == "0"
          total_length = binary_data.shift(15).join.to_i(2)
          packets = binary_data.shift(total_length)
          until packets.empty?
            sub_packets << Packet.parse(packets)
          end
        elsif length_type_id == "1"
          sub_packet_count = binary_data.shift(11).join.to_i(2)
          sub_packet_count.times do
            sub_packets << Packet.parse(binary_data)
          end
        end

        OperatorPacket.new(version, type, sub_packets)
      end

      def initialize(version, type, sub_packets)
        super(version, type)
        @sub_packets = sub_packets
      end

      def version_sum
        @version + @sub_packets.sum(&:version_sum)
      end

      def value
        sub_packet_values = @sub_packets.map(&:value)

        case @type
        when 0
          sub_packet_values.inject(&:+)
        when 1
          sub_packet_values.inject(&:*)
        when 2
          sub_packet_values.min
        when 3
          sub_packet_values.max
        when 5
          sub_packet_values[0] > sub_packet_values[1] ? 1 : 0
        when 6
          sub_packet_values[0] < sub_packet_values[1] ? 1 : 0
        when 7
          sub_packet_values[0] == sub_packet_values[1] ? 1 : 0
        end
      end
    end

    class Parser
      def initialize(input)
        @binary_data = input.each_char.map { |h| h.hex.to_s(2).rjust(4, "0") }
                            .map(&:each_char)
                            .flat_map(&:to_a)
      end

      def parse
        remaining_to_parse = @binary_data
        packets = []

        until remaining_to_parse.empty?
          byte_length = remaining_to_parse.length
          packets << Packet.parse(remaining_to_parse)
          bytes_read = byte_length - remaining_to_parse.length
          padding = 4 - (bytes_read % 4)
          remaining_to_parse.shift(padding)
        end

        packets
      end
    end

    def part1(input)
      packets = Parser.new(input).parse
      packets.sum(&:version_sum)
    end

    def part2(input)
      packets = Parser.new(input).parse
      packets.first.value
    end
  end
end
