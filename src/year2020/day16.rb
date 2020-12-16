module Year2020
  class Day16
    class Field
      attr_reader :name

      def self.parse(field_line)
        field_name, rules_range = field_line.split(": ")
        new(field_name, rules_range.split(" or ").map { |rule| Range.new(*rule.split("-").map(&:to_i)) })
      end

      def initialize(field_name, rules)
        @name = field_name
        @ranges = rules
      end

      def match?(value)
        @ranges.any? { |range| range.include?(value) }
      end

      def inspect
        @name + ": " + @ranges.inspect
      end
    end

    class Ticket
      attr_reader :values
      def initialize(values)
        @values = values
      end

      def invalid_values(rules)
        @values.select { |v| rules.none? { |rule| rule.match?(v) } }
      end

      def [](index)
        values[index]
      end

      def inspect
        @values.inspect
      end
    end

    def split_by(array)
      result = [a=[]]
      array.each{ |o| yield(o) ? (result << a=[]) : (a << o) }
      result.pop if a.empty?
      result
    end

    def parse_input(input)
      lines = input.split("\n")
      sections = split_by(lines, &:empty?)

      field_section = sections[0]
      fields = field_section.map { |field_line| Field.parse(field_line) }

      my_ticket = Ticket.new(sections[1][1].split(",").map(&:to_i))

      nearby_tickets = sections[2].drop(1).map { |line| line.split(",").map(&:to_i) }.map { |t| Ticket.new(t) }
      [fields, my_ticket, nearby_tickets]
    end

    def part1(input)
      fields, my_ticket, nearby_tickets = parse_input(input)

      nearby_tickets.sum { |t| t.invalid_values(fields).sum }
    end

    def part2(input)
      fields, my_ticket, nearby_tickets = parse_input(input)

      valid_tickets = nearby_tickets.select { |t| t.invalid_values(fields).empty? }
      all_tickets = valid_tickets + [my_ticket]

      indexed_values = all_tickets.each_with_object({}) do |t, memo|
        t.values.each_with_index do |val, index|
          memo[index] ||= []
          memo[index] << val
        end
      end

      matching_fields = indexed_values.each_with_object({}) do |(index, values), hash|
        hash[index] = fields.select { |f| values.all? { |v| f.match?(v) } }
      end

      found_fields = {}
      until matching_fields.empty? do
        matching_fields.select { |index, fields| (fields - found_fields.values).size == 1 }.each do |index, fields|
          found_fields[index] = (fields - found_fields.values).first
          matching_fields.delete(index)
        end
      end

      p found_fields

      result = found_fields.select { |_index, field| field.name.start_with?("departure") }
                  .map { |index, field| my_ticket[index] }
                  .inject(&:*)

      p result
    end
  end
end
