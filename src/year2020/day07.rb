module Year2020
  class Day07
    class Bag
      attr_reader :color, :included

      def self.parse(line)
        matching = line.match(/(?<color>[^ ]* [^ ]*) bags contain (?<included_bag_list>.*)./)
        bag = find_or_initialize(matching[:color])

        matching[:included_bag_list].split(", ").map do |bag_line|
          bag_match = bag_line.match(/(?<count>\d+) (?<color>[^ ]* [^ ]*) bags?/)
          if bag_match
            bag.add_included_bag(find_or_initialize(bag_match[:color]), bag_match[:count].to_i)
          end
        end
      end

      def self.find_or_initialize(color)
        @registry ||= {}
        if @registry.include?(color)
          @registry[color]
        else
          @registry[color] = Bag.new(color)
        end
      end

      def self.count_can_contain(included_bag)
        @registry.count { |color, bag| bag.include?(included_bag) }
      end

      def initialize(color)
        @color = color
      end

      def add_included_bag(bag, count)
        @included ||= {}
        @included[bag] = count
      end

      def include?(bag)
        @included&.include?(bag) || @included&.any? { |other_bag, _count| other_bag.include?(bag) }
      end

      def count_included_bags
        return 0 if @included == nil
        @included.sum { |bag, count| count + count * bag.count_included_bags }
      end
    end

    def part1(input)
      input.split("\n").each do |line|
        Bag.parse(line)
      end

      Bag.count_can_contain(Bag.find_or_initialize("shiny gold"))
    end

    def part2(input)
      input.split("\n").each do |line|
        Bag.parse(line)
      end

      Bag.find_or_initialize("shiny gold").count_included_bags
    end
  end
end
