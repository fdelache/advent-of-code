require 'debug'

module Year2024
  class Day05
    def part1(input)
      rules, updates = parse_input(input)

      updates.select { |update| update.valid?(rules) }
             .map(&:middle_page)
             .sum
    end

    def part2(input)
      rules, updates = parse_input(input)

      updates.reject { |update| update.valid?(rules) }
             .map { |update| update.reorder(rules) }
             .map(&:middle_page)
             .sum
    end

    private

    def parse_input(input)
      string_rules, updates = input.split("\n\n")

      rules = Hash.new { |h, k| h[k] = Set.new }
      string_rules.lines.each do |line|
        first, second = line.split('|').map(&:to_i)
        rules[first] << second
      end

      updates = updates.lines.map { |line| Update.parse(line) }

      [rules, updates]
    end
  end

  Node = Data.define(:page, :after) do
    def ==(other)
      page == other.page
    end
  end

  Update = Data.define(:pages) do
    def self.parse(line)
      pages = line.split(',')
      new(pages.map(&:to_i))
    end

    def valid?(rules)
      pages.combination(2).all? do |previous_page, page|
        rules[previous_page].include?(page)
      end
    end

    def reorder(rules)
      Update.new(pages.sort do |a, b|
        if rules[a].include?(b)
          -1
        elsif rules[b].include?(a)
          +1
        else
          0
        end
      end)
    end

    def middle_page
      pages[pages.size / 2]
    end
  end
end
