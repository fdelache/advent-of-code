module Year2020
  class Day19
    class Rule
      attr_accessor :char, :left, :right, :number

      def self.parse(rules)
        @rules = {}
        rules.each do |l|
          if /^(?<num>\d+): (\d+ ?)*$/ =~ l
            rule = find_or_initialize(num.to_i)
            sub_rules = l.split(": ").last.split(" ").map(&:to_i).map { |num| find_or_initialize(num) }
            rule.add_sub_rules(sub_rules, nil)
          elsif /^(?<num>\d+): (\d+ ?)+ \| (\d+ ?)+$/ =~ l
            rule = find_or_initialize(num.to_i)
            sub_rules = l.split(": ").last.split(" | ").map {|s| s.split(" ").map(&:to_i).map { |num| find_or_initialize(num) }}
            rule.add_sub_rules(*sub_rules)
          elsif /^(?<num>\d+): "(?<char>[a|b])"$/ =~ l
            rule = find_or_initialize(num.to_i)
            rule.char = char
          end
        end

        @rules[0]
      end

      def self.find_or_initialize(rule_number)
        @rules ||= {}
        @rules[rule_number] ||= Rule.new(rule_number)
      end

      def self.rules
        @rules
      end

      def initialize(number)
        @number = number
      end

      def add_sub_rules(left, right)
        @left = left || []
        @right = right || []
      end

      def char=(char)
        @char = char
      end

      def strings
        @strings ||= if char
          [char]
        else
          l = build_string(left)
          r = build_string(right)

          l + r
        end.uniq
      end

      def build_string(rules)
        r = rules.map {|r| r.strings}.inject(&:product)
        if r.nil?
          []
        elsif r.first.is_a?(Array)
          r.map(&:join)
        else
          r
        end
      end

      def match?(string)
        strings.any? { |s| s == string }
      end
    end

    def part1(input)
      lines = input.split("\n\n")

      rules = lines[0].split("\n")
      messages = lines[1].split("\n")

      r_zero = Rule.parse(rules)
      puts r_zero.strings.size

      messages.count { |m| r_zero.match?(m) }
    end

    def part2(input)
      lines = input.split("\n\n")

      rules = lines[0].split("\n")
      messages = lines[1].split("\n")

      r_zero = Rule.parse(rules)
      puts "Rules count: #{r_zero.strings.size}"
      puts "Message count: #{messages.size}"
      puts "Biggest message: #{messages.map(&:size).max}"

      rule_42_strings = Rule.find_or_initialize(42).strings.uniq.sort
      puts "Rule 42 has #{rule_42_strings.size} possible cases, #{rule_42_strings.map(&:size).minmax}"

      rule_31_strings = Rule.find_or_initialize(31).strings.uniq.sort
      puts "Rule 31 has #{rule_31_strings.size} possible cases, #{rule_31_strings.map(&:size).minmax}"

      slice_size = rule_42_strings.first.size
      messages.select! { |m| m.size % slice_size == 0 }

      sliced_messages = messages.map {|m| slice(m, slice_size)}
      removed_rule_42 = sliced_messages.map do |m|
        updated = m.drop_while { |s| rule_42_strings.include?(s) }
        [updated, m.size - updated.size]
      end

      removed_rule_42.count do |m, dropped_42_count|
        updated = m.drop_while { |s| rule_31_strings.include?(s) }
        dropped_31_count = m.size - updated.size
        updated.empty? && dropped_31_count.between?(1, dropped_42_count-1)
      end
    end

    def slice(message, size)
      message.scan(/\w{#{size}}/)
    end
  end
end
